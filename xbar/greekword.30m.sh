#!/bin/bash

# <xbar.title>Greek Word of the Day</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Your Name</xbar.author>
# <xbar.author.github>yourusername</xbar.author.github>
# <xbar.desc>Displays a Greek word with English translation and pronunciation</xbar.desc>
# <xbar.dependencies>curl,jq</xbar.dependencies>

# Fetch data from API
response=$(curl -s "https://greek-menubar.netlify.app/.netlify/functions/api")

# Check if curl was successful
if [ $? -ne 0 ] || [ -z "$response" ]; then
    echo "❌"
    echo "---"
    echo "Failed to fetch data"
    exit 1
fi

# Parse JSON using jq
greek=$(echo "$response" | jq -r '.Greek')
english=$(echo "$response" | jq -r '.English')
pronunciation=$(echo "$response" | jq -r '.Pronunciation // empty')
description=$(echo "$response" | jq -r '.Description // empty')
examples=$(echo "$response" | jq -r '.Examples // empty')

# Display Greek word as title
echo "$greek"
echo "---"
echo "English: $english | refresh=true"

# Only show pronunciation if it exists
if [ -n "$pronunciation" ]; then
    echo "Pronunciation: $pronunciation | refresh=true"
fi

# Only show description if it exists
if [ -n "$description" ]; then
    echo "Description: $description | refresh=true"
fi

# Only show examples if they exist
if [ -n "$examples" ]; then
    echo "Examples: $examples | refresh=true"
fi