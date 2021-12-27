use terminal_clipboard;

use chrono::{DateTime, Utc};
use std::fs;
use std::process::Command;

// TODO: copy to clipboard
pub fn copy_to_clip(content: &str) {
    terminal_clipboard::set_string(content).expect("Couldnt Copy to Clipboard!");
    println!(
        "Content in Clip now: {}",
        terminal_clipboard::get_string().unwrap()
    );
}
pub fn to_hex(v: &Vec<u8>) -> String {
    format!("#{:x}{:x}{:x}", &v[0], &v[1], &v[2])
}
pub fn to_rgb(v: &Vec<u8>) -> String {
    format!("rgb({},{},{})", &v[0], &v[1], &v[2])
}

pub fn delete_ss(file: String) {
    match fs::remove_file(file) {
        Ok(_) => {}
        Err(e) => println!("Couldnt delete temp screenshot! {}", e),
    };
}

pub fn screenshot() -> String {
    let now: DateTime<Utc> = Utc::now();
    // let filename = now.format("screenshot%d_%m_%Y__%H_%M_%S.png").to_string();
    let filename = now.format("./screenshot.png").to_string();

    Command::new("scrot")
        .args(&["-z", &filename])
        .output()
        .expect("Couldnt get screenshot!");

    filename.to_string()
}
