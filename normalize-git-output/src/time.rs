//! Handle non-reproducibility caused by timestamps

use crate::editor::LogEditor;
use regex::Regex;
use std::sync::LazyLock;

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
pub fn normalize_time(editor: &mut LogEditor) {
    editor.replace_regex(&GIT_REGEX, "Ddd Mmm DD HH:MM:SS YYYY +ZZZZ");
    editor.replace_regex(&LS_REGEX, "Mmm DD HH:MM");
}
