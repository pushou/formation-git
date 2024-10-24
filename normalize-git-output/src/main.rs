pub mod editor;
mod hash;
mod time;

use editor::LogEditor;
use std::{env, fs};

fn main() {
    // Set up logging and load user-specified log file
    env_logger::init();
    assert_eq!(
        env::args().count(),
        2,
        "Please indicate which file should be normalized"
    );
    let input_name = env::args().nth(1).unwrap();
    let input = fs::read_to_string(input_name).expect("Failed to open input file");

    // Normalize log file and print out the result
    let mut editor = LogEditor::new(input);
    remove_token_and_pubkey(&mut editor);
    hash::normalize_hashes(&mut editor);
    time::normalize_time(&mut editor);
    hide_user_group_homedir(&mut editor);
    editor.print();
}

/// Remove gitlab token and public keys
///
/// Must be done before `normalize_hashes` because the latter would mistake
/// "ed25519" for a git hash and mangle it.
fn remove_token_and_pubkey(editor: &mut LogEditor) {
    editor.rewrite(|log, output| {
        for line in log.lines() {
            if line.starts_with("remote.origin.url=") {
                log::info!("Removed a gitlab token");
                output.push_str(
                    "remote.origin.url=https://gitlab.in2p3.fr/grasland/formation-git.git",
                );
            } else if line.starts_with("ssh-ed25519 ") && line.ends_with(" formation-git") {
                log::info!("Replaced an SSH public key with a placeholder");
                output.push_str("ssh-pubkey SSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSHSSH formation-git");
            } else {
                output.push_str(line);
            }
            output.push('\n');
        }
    });
    editor.replace_fixed("ed25519", "pubkey");
}

/// Try to replace usernames, references to the user's main group (root if root,
/// users otherwise) and home directory paths with a fixed pattern
fn hide_user_group_homedir(editor: &mut LogEditor) {
    if let Ok(homedir) = env::var("HOME") {
        editor.replace_fixed(&homedir, "$HOME");
    } else {
        log::warn!("Could not normalize home directory because HOME is not set");
    }
    if let Ok(username) = env::var("USER") {
        if username == "root" {
            editor.replace_fixed("root root", "$USER $GROUP");
        } else {
            editor.replace_fixed(&format!("{username} users"), "$USER $GROUP");
        }
        editor.replace_fixed(&format!("whoami\n{username}"), "whoami\n$USER");
    } else {
        log::warn!("Could not normalize username because USER is not set");
    }
}
