# perl_object_reader
This is a perl script that can read objects into memory

The format you must use to read objects into memory is as follows:

1. Create a txt file in the `files_to_process` directory. Start an object with `==`.
2. In order to create key-value pairs, simple type it as 
`key: value`
3. End the object with `/==`
4. repeat steps 2-3 until you have create all your objects.
5. run the script using `perl object_reader.pl`
6. The script will print your objects to the console.

This script is meant to be extended so that you can use txt files and transfer them to JSON or other useful formats. You can also change what kind of files are read by changing `my $type` to a different format. Further coding will need to be done to accept multiple file formats.
