#!/bin/bash

# <xbar.title>Greek Word of the Day</xbar.title>
# <xbar.version>v1.1</xbar.version>
# <xbar.author>Your Name</xbar.author>
# <xbar.author.github>blackspike</xbar.author.github>
# <xbar.desc>Displays a Greek word with English translation and pronunciation</xbar.desc>
# <xbar.dependencies>curl,jq</xbar.dependencies>

# Fetch data from API
response=$(curl -s "https://rigorous-peacock.pikapod.net/api/collections/little_bit_of_json/records/9rzx68ncli8b4n4")

# Check if curl was successful
if [ $? -ne 0 ] || [ -z "$response" ]; then
    echo "❌"
    echo "---"
    echo "Failed to fetch data"
    exit 1
fi

# Extract the json array
words=$(echo "$response" | jq '.json')

# Check if json field exists
if [ -z "$words" ] || [ "$words" = "null" ]; then
    echo "❌"
    echo "---"
    echo "Failed to parse JSON field"
    exit 1
fi

# Get the array length
length=$(echo "$words" | jq 'length')

# Generate a random index
random_index=$((RANDOM % length))

# Select a random word from the array
word=$(echo "$words" | jq ".[$random_index]")

# Parse the selected word
greek=$(echo "$word" | jq -r '.greek')
english=$(echo "$word" | jq -r '.english')
pronunciation=$(echo "$word" | jq -r '.pronunciation // empty')
description=$(echo "$word" | jq -r '.description // empty')
examples=$(echo "$word" | jq -r '.examples // empty')

# Display Greek word as title
echo "$greek"
echo "---"
echo "$english | refresh=true"

# Only show pronunciation if it exists
if [ -n "$pronunciation" ]; then
    echo "$pronunciation | refresh=true"
fi

# Only show description if it exists
if [ -n "$description" ]; then
    echo "$description | refresh=true"
fi

# Only show examples if they exist
if [ -n "$examples" ]; then
    echo "$examples | refresh=true"
fi