let g:mail_netrc='~/.netrc'
let g:mail_imap_ssl=1
if exists('g:mail_account') && g:mail_account == 'fib'
    " fib
    let g:mail_smtp_server='mail.fib.upc.es'
    let g:mail_smtp_port=1025
    let g:mail_imap_server='correu.fib.upc.es'
    let g:mail_imap_port=993
else
    " gmail
    let g:mail_smtp_server='smtp.gmail.com'
    let g:mail_smtp_port=587
    let g:mail_imap_server='imap.gmail.com'
    let g:mail_imap_port=993
endif
