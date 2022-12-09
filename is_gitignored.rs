use std::path::Path;
use std::fs;
use std::error::Error;

// Function that checks if a file path is ignored by the .gitignore file
// in the closest ancestor directory of the file path
fn is_ignored(file_path: &Path) -> Result<bool, Box<dyn Error>> {
    // Check if the file path exists
    if !file_path.exists() {
        return Ok(false);
    }

    // Get the closest ancestor directory with a .gitignore file
    let mut current_dir = file_path.parent().unwrap();
    while !current_dir.join(".gitignore").exists() {
        current_dir = current_dir.parent().unwrap();
    }

    // Read the contents of the .gitignore file
    let gitignore_file = current_dir.join(".gitignore");
    let gitignore_contents = fs::read_to_string(gitignore_file)?;

    // Check if the file path is ignored by the .gitignore file
    let relative_file_path = file_path.strip_prefix(current_dir)?;
    Ok(gitignore_contents.lines().any(|line| {
        line.trim() == relative_file_path ||
        line.trim().ends_with('/') && relative_file_path.starts_with(line.trim())
    }))
}

// Test the is_ignored function with some file paths
fn main() {
    let test_cases = [
        ("/path/to/repo/.gitignore", false),
        ("/path/to/repo/src/main.rs", true),
        ("/path/to/repo/src/lib.rs", false),
        ("/path/to/repo/target/debug/main", true),
        ("/path/to/repo/target/debug/lib", false),
    ];
    for (file_path, expected_result) in test_cases.iter() {
        let file_path = Path::new(file_path);
        let result = is_ignored(file_path).unwrap();
        assert_eq!(result, *expected_result);
    }
}
