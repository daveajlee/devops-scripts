#Define variables
OLD_DIRECTORY_PATH=$1;
NEW_DIRECTORY_PATH=$2;
SUBDIRECTORY_NAME=$3
BRANCH_NAME=$4
FOLDER_NAME=$5

#Copy the content
cd $OLD_DIRECTORY_PATH
git filter-branch —prune-empty —subdirectory-filter /$SUBDIRECTORY_NAME/
#Move it to the new folder
cd $NEW_DIRECTORY_PATH
#Do the git operations with adding, pulling and deleting
git remote add $BRANCH_NAME ../$FOLDER_NAME/
git pull $BRANCH_NAME master
git remote rm $BRANCH_NAME

#Complete the operation by pushing everything
git push