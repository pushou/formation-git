//! Handle non-reproducibility caused by timestamps

use std::{mem, sync::LazyLock};

use regex::Regex;

/// Regex to find dates in the format emitted by ls
static LS_REGEX: LazyLock<Regex> = LazyLock::new(|| {
    Regex::new(
        r"(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) [0-9]?[1-9] [0-9]{1,2}:[0-9]{1,2}",
    )
    .unwrap()
});

/// Regex to find dates in the format emitted by git
static GIT_REGEX: LazyLock<Regex> = LazyLock::new(|| {
    Regex::new(&format!(
        r"(Mon|Tue|Wed|Thu|Fri|Sat|Sun) {}:[0-9]{{1,2}} [1-9][0-9]{{3}} \+[0-9]{{1,4}}",
        LS_REGEX.as_str()
    ))
    .unwrap()
});

/// Normalize dates
///
/// Should be done after normalize_hashes because it generates sequences that a
/// future version of normalize_hashes might mistake for a hash.
pub fn normalize_time(log: &mut String) {
    let mut output = String::with_capacity(log.len());
    let mut replace_with_placeholder = |regex: &Regex, name, placeholder| {
        let mut next_start = 0;
        for m in regex.find_iter(log) {
            output.push_str(&log[next_start..m.start()]);
            log::info!("Found {name}-style date {m:?}, replaced it with a placeholder");
            output.push_str(placeholder);
            next_start = m.end();
        }
        output.push_str(&log[next_start..]);
        mem::swap(log, &mut output);
        output.clear();
    };
    replace_with_placeholder(&GIT_REGEX, "git", "Ddd Mmm DD HH:MM:SS YYYY +ZZZZ");
    replace_with_placeholder(&LS_REGEX, "ls", "Mmm DD HH:MM");
}
