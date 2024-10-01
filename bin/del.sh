#!/bin/bash

# Iterate over all branches excluding the currently checked out branch
for k in $(git branch | sed /\*/d); do 
  # Get the last commit date of the branch
  last_commit_date=$(git log -1 --format=%ci $k)
  
  # Check if the branch has no commits in the last 2 months
  if [ -z "$(git log -1 --since='2 months ago' -s $k)" ]; then
    # Display the last commit date and prompt for confirmation before deleting the branch
    read -p "The last commit on branch '$k' was on $last_commit_date. Are you sure you want to delete this branch? (y/n): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      # Force delete the branch if the user confirms
      git branch -D $k
      echo "Branch '$k' deleted."
    else
      echo "Branch '$k' not deleted."
    fi
  fi
done

