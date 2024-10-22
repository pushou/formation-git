mod hash;
mod time;

use std::{env, fs};

// Minimum sequence of hexadecimal digits treated as a git hash
//
// Must be >6 otherwise git file modes will be treated as git hashes.
// Empirically, current versions of git emit 7 hex digits so we're fine.
const MIN_GIT_HASH_LEN: usize = 7;

fn main() {
    env_logger::init();
    assert_eq!(
        env::args().count(),
        2,
        "Please indicate which file should be normalized"
    );
    let input = env::args().nth(1).unwrap();
    let mut input = fs::read_to_string(input).expect("Failed to open file");
    remove_token_and_pubkey(&mut input);
    hash::normalize_hashes(&mut input);
    time::normalize_time(&mut input);
    println!("{input}");
}

/// Remove gitlab token and public keys
///
/// Must be done before normalize_hashes, as the latter would mistake "ed25519"
/// for a git hash and mangle it.
fn remove_token_and_pubkey(log: &mut String) {
    let mut output = String::with_capacity(log.len());
    for line in log.lines() {
        if line.starts_with("remote.origin.url=") {
            output.push_str("remote.origin.url=https://gitlab.in2p3.fr/grasland/formation-git.git");
        } else if line.starts_with("ssh-ed25519 ") && line.ends_with(" formation-git") {
            output.push_str("ssh-pubkey SSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSS formation-git");
        } else {
            let mut next_start = 0;
            for (idx, ed25519) in line.match_indices("ed25519") {
                output.push_str(&line[next_start..idx]);
                output.push_str("pubkey");
                next_start = idx + ed25519.len();
            }
            output.push_str(&line[next_start..]);
        }
        output.push('\n');
    }
    *log = output;
}
