# Forensics
## Systematics in Docker Container
1. First the resources `index.html` and `mona_lisa.jpg` are copied to web server's web-root created in future.
2. In a second step Python's http module is used to spawn a web service waiting for incoming http requests on TCP 8080.

## Solving the challenge

At first you would have to grab the image hosted by the web server.
In asecond step you will notice, that the jpeg image embeds a second file:
It's possible to extract embedded file with an empty passphrase.
```bash
$ steghide info mona_lisa.jpg

"mona_lisa.jpg":
  Format: jpeg
  Kapazität: 23,2 KB
  Eingebettete Datei "archived.zip":
    Größe: 236,0 Byte
    verschlüsselt: nein
    komprimiert: ja
    
$ steghide extract -sf mona_lisa.png 
Enter passphrase:
wrote extracted data to "archived.zip".

$ zipnote archived.zip

@ secret.txt
We will ROCKYOU.
@ (comment above this line)
@ (zip file comment below this line)
```

The comment included in the zip archive shall be a hint to use any zip-cracking utility of choice to extract the included flag.

``` bash
$ python2 ./zipcracker.py -f archived.zip -w /usr/share/wordlists/rockyou.txt

Password cracked: snowball

Took 0.916578 seconds to crack the password. That is, 725 attempts per second.

$ unzip archived.zip

Archive:  archived.zip
extracting: secret.txt              

```

