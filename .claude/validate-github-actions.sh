#!/bin/bash

if ! cat - | cue cmd validate >&2; then
	exit 2
fi
