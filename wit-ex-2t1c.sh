bash$ ls
bottom.wiki hello.wiki top.wiki
bash$ cat hello.wiki
= Hello world!
This is the content wiki.
bash$ cat top.wiki
Template above.
<<content>>
bash$ cat bottom.wiki
<<content>>
Template below.
bash$
bash$ cat hello.wiki | wit top.wiki | wit bottom.wiki
Template above.
= Hello world!
This is the content wiki.
Template below.
bash$
