//! Mechanism to efficiently edit a git log

use regex::Regex;
use std::{mem, ops::Range};

/// Git log editor
pub struct LogEditor {
    /// Log that we're working with
    log: String,

    /// Temporary buffer used to store output string in some algorithms
    output: String,

    /// Temporary buffer used to store pattern matches in replace_impl
    matches: Vec<Range<usize>>,
}
//
impl LogEditor {
    /// Set things up
    pub fn new(log: String) -> Self {
        let output = String::with_capacity(log.len());
        Self {
            log,
            output,
            matches: Vec::new(),
        }
    }

    /// Access the log mutably for in-place editing
    pub fn get_mut(&mut self) -> &mut String {
        &mut self.log
    }

    /// Transform the current log into a new string
    ///
    /// An empty preallocated buffer is provided, it should be filled with the
    /// modified log contents. At the end of the user-provided callback
    /// function, the log will be replaced with this string.
    pub fn rewrite(&mut self, fill_buffer: impl FnOnce(&str, &mut String)) {
        fill_buffer(&self.log, &mut self.output);
        mem::swap(&mut self.log, &mut self.output);
        self.output.clear();
    }

    /// Replace every occurence of a string with another string
    pub fn replace_fixed(&mut self, pattern: &str, replacement: &str) {
        log::debug!("Looking for occurences of fixed string {pattern:?}...");
        self.replace_impl(
            |log, matches| {
                matches.extend(
                    log.match_indices(pattern)
                        .inspect(|(idx, _pat)| log::debug!("Found occurence at position {idx}"))
                        .map(|(idx, pattern)| idx..idx + pattern.len()),
                )
            },
            replacement,
        );
        log::info!("Replaced every occurence of fixed string {pattern:?} with {replacement:?}");
    }

    /// Replace every occurence of a regex with a fixed string
    pub fn replace_regex(&mut self, pattern: &Regex, replacement: &str) {
        log::debug!("Looking for occurences of regex {pattern}...");
        self.replace_impl(
            |log, matches| {
                matches.extend(
                    pattern
                        .find_iter(log)
                        .inspect(|m| {
                            log::debug!("Found occurence {} at position {}", m.as_str(), m.start())
                        })
                        .map(|m| m.range()),
                )
            },
            replacement,
        );
        log::info!("Replaced every occurence of regex {pattern} with {replacement:?}");
    }

    /// Implementation of the `replace_xyz` operations
    fn replace_impl(
        &mut self,
        collect_matches: impl FnOnce(&str, &mut Vec<Range<usize>>),
        replacement: &str,
    ) {
        collect_matches(&self.log, &mut self.matches);
        let mut matches = mem::take(&mut self.matches);
        self.rewrite(|log, output| {
            let mut next_start = 0;
            for o in matches.drain(..) {
                output.push_str(&log[next_start..o.start]);
                output.push_str(replacement);
                next_start = o.end;
            }
            output.push_str(&log[next_start..]);
        });
        self.matches = matches;
    }

    /// Emit the normalized string to stdout
    pub fn print(self) {
        println!("{}", self.log)
    }
}
