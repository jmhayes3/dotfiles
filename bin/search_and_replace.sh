#!/usr/bin/env bash

find . -type f -name "*baz*" -exec sed -i '' 's/foo/bar/g' {} +
