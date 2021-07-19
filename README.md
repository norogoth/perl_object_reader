# Perl Object Reader
This is a perl script that can read hashes into memory using txt files.

## Instructions 

1. Create a txt file in the `files_to_process` directory. Start an object with `==`.
2. In order to create key-value pairs, simple type it as 
`key: value`
3. Repeat for as many key-value pairs as your like. Here is an example.
```
==
Name: Doris Peaver
Race: Elf
Background: Totem Carver
Description: An elf who speaks very little.
/==

This text will be ignored

==
Name: Jackson
Race: human
Background: Shepard
Description: A man that looks after sheep and occasionally attempts to act bravely in battle.
/==

```
4. End the object with `/==`
5. repeat steps 2-3 until you have create all your objects.
6. run the script using `perl object_reader.pl`
7. The script will print your hashmaps to the console.

x-special/nautilus-clipboard

![example](https://user-images.githubusercontent.com/52639031/126234375-14d74a56-a273-445b-aaa5-8328bb474ca9.png)


This script is meant to be extended so that you can use this very simple format with txt files and transfer them to JSON or other useful formats. You can also change what kind of files are read by changing `my $type` to a different format. Currently there are two sample files in the "files_to_process" folder. You may add as many files as you like. 

Some minor further coding will need to be done to accept multiple file formats.
