Rest API application with the next functionality:
- When creating a task, the URLs field is passed to it, in which the links are indicated to files. It can be any links on any site, the only
condition - it should be linked to files. After creating a task
these files are merged into an archive and this archive is uploaded to AWS S3. 
For example, 3 links were transmitted in the URLs field. They should be combined into one archive and this archive should be uploaded to S3. 
- After the beginning of the archive formation, the task's status field is changed to 'processing', in case of an error - changed to 'failed', after completion - to 'finished'
- During the formation of the archive - the progress field is changed, in which it should indicate the percentage of the archive formation.
- When changing any of the fields of the task - information about this is sent by WebSockets.
- After completion of the archive formation, a link is sent via WebSockets to the generated archive