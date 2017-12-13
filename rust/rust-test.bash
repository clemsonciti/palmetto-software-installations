#!/usr/bin/env bash

major=1
minor=22
patch=1

module add rust/${major}.${minor}.${patch}

cat << EOF > hello.rs
// This is the main function
fn main() {
    // The statements here will be executed when the compiled binary is called

    // Print text to the console
    println!("Hello World!");
}
EOF

set -x

# Compile the example
rustc hello.rs

# Test example
./hello

ls -lah
rm -f hello.rs hello

