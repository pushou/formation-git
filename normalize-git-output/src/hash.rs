//! Handle non-reproducibility caused by (time-dependent) git commit hashes

use crate::MIN_GIT_HASH_LEN;
use std::collections::{hash_map::Entry, BTreeMap, HashMap, HashSet};

/// Replace non-reproducible git commit hashes a reproducible base62 identifier
pub fn normalize_hashes(log: &mut str) {
    // Detect git hashes and their positions of occurence
    let mut hash_to_info = find_hashes(log);

    // Merge long hashes with their shortened equivalent
    merge_short_hashes(&mut hash_to_info);

    // List hash occurences, sorted by position
    #[derive(Clone, Copy)]
    struct OccurrenceInfo {
        id: usize,
        length: usize,
    }
    let occurences_by_position = hash_to_info
        .into_iter()
        .flat_map(|(hash, hash_info)| {
            let info = OccurrenceInfo {
                id: hash_info.id,
                length: hash.len(),
            };
            hash_info
                .positions
                .into_iter()
                .map(move |position| (position, info))
        })
        .collect::<BTreeMap<_, _>>();

    // Normalize hash occurences by replacing them with a repeated base62 ID. In
    // the future, if we end up dealing with more than 62 unique hashes in a git
    // log, we'll decompose the id into multiple digits and emit the truncated
    // repeated sequence of those digits (e.g. aZaZaZa) instead.
    let base62_ids = (b'A'..=b'Z')
        .chain(b'a'..=b'z')
        .chain(b'0'..=b'9')
        .collect::<Box<[_]>>();
    // SAFETY: Will only replace ASCII bytes with ASCII ids from base62_ids
    let log_bytes = unsafe { log.as_bytes_mut() };
    for (position, occurence) in occurences_by_position {
        log_bytes[position..position + occurence.length].fill(base62_ids[occurence.id]);
    }
}

/// Find git commit hashes and allocate IDs based on their order of appearance
fn find_hashes(log: &str) -> HashMap<&[u8], HashInfo> {
    let log_bytes = log.as_bytes();
    let mut next_id = 0;
    let mut hash_to_info = HashMap::<_, HashInfo>::new();
    let mut state = FinderState::CanStart;
    let is_lowercase_hexdigit = |byte: u8| byte.is_ascii_digit() || (b'a'..=b'f').contains(&byte);
    for (idx, byte) in log_bytes.iter().copied().enumerate() {
        match state {
            FinderState::CannotStart => {
                if !byte.is_ascii_alphanumeric() {
                    state = FinderState::CanStart;
                }
            }
            FinderState::CanStart => {
                if is_lowercase_hexdigit(byte) {
                    state = FinderState::ProcessingCandidate { start: idx };
                } else if byte.is_ascii_alphabetic() {
                    state = FinderState::CannotStart;
                }
            }
            FinderState::ProcessingCandidate { start } => {
                if is_lowercase_hexdigit(byte) {
                    continue;
                }
                if byte.is_ascii_alphabetic() {
                    state = FinderState::CannotStart;
                    continue;
                }
                state = FinderState::CanStart;
                if idx - start < MIN_GIT_HASH_LEN {
                    continue;
                }
                let hash = &log_bytes[start..idx];
                // Ignore the 0000000 hash, because unlike others it is
                // reproducible (git only emits it in special circumstances,
                // e.g. file additions and deletions in diff)
                if hash.iter().all(|&b| b == b'0') {
                    continue;
                }
                match hash_to_info.entry(hash) {
                    Entry::Occupied(mut o) => {
                        log::debug!(
                            "Found new occurence of hash {} (id {}) at position {start}",
                            std::str::from_utf8(hash).unwrap(),
                            o.get().id,
                        );
                        o.get_mut().positions.push(start);
                    }
                    Entry::Vacant(v) => {
                        log::info!(
                            "Found new hash {} at position {start}, allocated id {next_id}",
                            std::str::from_utf8(hash).unwrap(),
                        );
                        v.insert(HashInfo {
                            id: next_id,
                            positions: vec![start],
                        });
                        next_id += 1;
                    }
                }
            }
        }
    }
    hash_to_info
}

/// Information about a git commit hash
struct HashInfo {
    /// Unique identifier
    ///
    /// Each hash gets assigned an ID from 0 up, based on their order of first
    /// occurence in the log. Initially, shortened hashes are treated as
    /// distinct from the corresponding full commit hash, but they are merged in
    /// a subsequent unification step.
    id: usize,

    /// Positions where this hash appears in the log
    positions: Vec<usize>,
}

/// State of the hash-finding process
enum FinderState {
    /// A hash cannot start on the next byte
    ///
    /// This state is entered upon observing a non-hexadecimal alphanumerical
    /// ASCII char. It is left on the next non-alphanumerical character. We
    /// consider that a hash may only be surrounded by non-alphabetical chars,
    /// otherwise it's likely a word mistaken as a hash...
    CannotStart,

    /// A hash can start on the next byte
    ///
    /// This is the starting state of the parser, and the parser goes back to
    /// this state whenever it is not processing a hash candidate and a hash
    /// candidate could legitimately start on the next byte.
    CanStart,

    /// Processing a hash candidate
    ///
    /// This state is entered when the parser encounters a hexadecimal digit and
    /// parsing is not inhibited via CannotStart. It is left when a byte other
    /// than a hexadecimal digit is encountered. At that time, a hash occurence
    /// may be recorded if all conditions are met.
    ProcessingCandidate { start: usize },
}

/// Merge git commit hashes and their shortened form into a single ID
///
/// This is only done when the association between a long and a short commit
/// hash is unambiguous, i.e. there aren't two different long hashes which could
/// be shortened into the same short hash.
fn merge_short_hashes(hash_to_info: &mut HashMap<&[u8], HashInfo>) {
    // Categorize hashes by length. We only expect to find <=2 categories: full
    // hashes and shortened hashes, some of which can be absent.
    let mut len_to_hashes = BTreeMap::<_, HashSet<_>>::new();
    for hash in hash_to_info.keys() {
        let inserted = len_to_hashes.entry(hash.len()).or_default().insert(*hash);
        debug_assert!(inserted);
    }
    assert!(len_to_hashes.len() <= 2);

    // Pair up shortened hashes with the corresponding full hash, if both are
    // present. From this infer a list of unified hash occurences, identified by
    // their rank of first occurence.
    if len_to_hashes.len() == 2 {
        // Get list of short and long hashes
        let (short_len, short_hashes) = len_to_hashes.pop_first().unwrap();
        debug_assert!(short_len >= MIN_GIT_HASH_LEN);
        let (long_len, long_hashes) = len_to_hashes.pop_last().unwrap();
        debug_assert!(long_len > short_len);
        debug_assert!(len_to_hashes.is_empty());

        // Find short -> long hash mapping, identifying ambiguities
        let mut short_to_longs = HashMap::<_, Vec<_>>::new();
        for long_hash in long_hashes {
            let short_hash = &long_hash[..short_len];
            if short_hashes.contains(short_hash) {
                short_to_longs
                    .entry(short_hash)
                    .or_default()
                    .push(long_hash);
            }
        }

        // Whenever a short hash corresponds to exactly one long hash, give
        // them the first ID, inferred by first occurence
        let mut merged_ids = false;
        for (short, longs) in short_to_longs {
            if longs.len() == 1 {
                merged_ids = true;
                let long = longs.into_iter().next().unwrap();
                let short_id = hash_to_info[short].id;
                let long_id = hash_to_info[long].id;
                if short_id < long_id {
                    log::info!(
                        "Merged long hash {} with id {long_id} into short hash {} with id {short_id}",
                        std::str::from_utf8(long).unwrap(),
                        std::str::from_utf8(short).unwrap(),
                    );
                    hash_to_info.get_mut(long).unwrap().id = short_id;
                } else {
                    debug_assert!(long_id > short_id);
                    log::info!(
                        "Merged short hash {} with id {short_id} into long hash {} with id {long_id}",
                        std::str::from_utf8(short).unwrap(),
                        std::str::from_utf8(long).unwrap(),
                    );
                    hash_to_info.get_mut(short).unwrap().id = long_id;
                }
            } else {
                log::info!(
                    "Cannot merge short hash {} as it matches multiple long hashes",
                    std::str::from_utf8(short).unwrap()
                );
            }
        }

        // If this happened at least once, renumber the IDs sequentially
        if merged_ids {
            let mut id_to_hashes = BTreeMap::<_, Vec<_>>::new();
            for (&hash, info) in hash_to_info.iter() {
                id_to_hashes.entry(info.id).or_default().push(hash);
            }
            for (new_id, hashes) in id_to_hashes.into_values().enumerate() {
                let old_id = hash_to_info[hashes[0]].id;
                if old_id != new_id {
                    for hash in hashes {
                        log::info!(
                            "Renumbered hash {} to id {new_id}",
                            std::str::from_utf8(hash).unwrap()
                        );
                        hash_to_info.get_mut(hash).unwrap().id = new_id;
                    }
                }
            }
        }
    }
}
