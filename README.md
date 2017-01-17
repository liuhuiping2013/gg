# goto your favorite path fastly

## install
1. copy .gg to your home directory  
cp .gg ~  

2. add alias to your sh profile  
```bash
vim .bashrc # add lines like below  
alias gg='. ~/.gg ~/.gg'  
```
    now relogin your accout, good luck!  
## usage
```bash
gg                # show all your favorite path, and then you can choose one to enter
gg <num>          # fast enter your favorite path as upon
gg a              # add current path to your favorites
gg d              # del current path from your favorites
```

## not bash?
question is, buildin command `read` different from bash.  

- bash "-n1" read one character
- zsh "-k" read one character
