#![feature(lang_items)] // required for defining the panic handler
#![feature(const_fn)]
#![no_std] // don't link the Rust standard library
#![no_main] // disable all Rust-level entry points

extern crate volatile;
extern crate rlibc;
extern crate spin;

#[macro_use]
extern crate lazy_static;

#[macro_use]
mod vga_buffer;


#[lang = "panic_fmt"] // define a function that should be called on panic
#[no_mangle]
pub extern fn rust_begin_panic(_msg: core::fmt::Arguments,
                               _file: &'static str, _line: u32, _column: u32) -> !
{
    loop {}
}

#[no_mangle] // don't mangle the name of this function
pub extern fn _start() -> ! {
    println!("Hello world!");
    println!("Some numbers: {} {}", 42, 1.337);

    loop {}
}
