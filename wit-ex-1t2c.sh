bash$ ls
title.wiki text.wiki template.wiki
bash$ cat title.wiki
= Hello world!
bash$ cat text.wiki
Some text.
bash$ cat template.wiki
Before first.
<<content>>
In between.
<<content>>
After.
bash$
bash$ wit <(wit template.wiki < title.wiki) < text.wiki
Before first.
= Hello world!
In between.
Some text.
After.
bash$
