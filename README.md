# js-transform

## About

This project is a proof of concept/blueprint implementation of text-to-text transformations in javascript.
While aimed to be easily adopted it is, by design, not suitable as a library.

## Concept

A Team reads the specification of InputFormat and defines a implementation with the terminology of the source format.
In parallel a team defines or reviews the specification of the OutputFormat and writes template-based renderers
Now the teams merge and a intermediate or gateway Model between the two formats is declared. After few cycles, the mapping is complete.

## Building

```
npm install
```

## Running

console application to convert a given input file to the from the given input format to the given output format
```
node src/app.js test-data/test.xml OSM JSON
```

will proccess the file ```test-data/test.xml``` with the input mapping OSM (node-key-attributes) and the output mapping JSON (passthrough)

## License

Copyright (c) 2015, git-j@refeus.de

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice  and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
