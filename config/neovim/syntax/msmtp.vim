" Vim syntax file
" Language: mbsync configuration

if exists("b:current_syntax")
	finish
endif

let s:keepcpo = &cpo
set cpo&vim

" Comments.
syn match msmtpcomment /#.*$/ contains=@Spell,@spell

" General commands.
syntax keyword msmtpoption
			\ defaults account eval host port source_ip proxy_host proxy_port
			\ socket timeout protocol domain

" Authentication commands.
syntax keyword msmtpoption auth user password passwordeval ntlmdomain

" TLS commands.
syntax keyword msmtpoption
			\ tls tls_starttls tls_trust_file tls_crl_file tls_fingerprint
			\ tls_key_file tls_cert_file tls_certcheck tls_priorities
			\ tls_host_override tls_min_dh_prime_bits

" Sendmail mode specific commands.
syntax keyword msmtpoption
			\ from allow_from_override dsn_notify dsn_return set_from_header
			\ set_date_header set_msgid_header remove_bcc_headers
			\ undisclosed_recipients logfile logfile_time_format syslog aliases
			\ auto_from maildomain

" Options which accept only an on/off value.
syn match msmtpwrongoption /\<\(tls\|tls_starttls\|tls_certcheck\|allow_from_override\|remove_bcc_headers\|undisclosed_recipients\|auto_from\) \(on$\|off$\)\@!.*$/ contains=msmtpbool,msmtpwrongoptionvalue

" Options which accept only an on/off value.
syn match msmtpwrongoption /\<\(tls\|tls_starttls\|tls_certcheck\|allow_from_override\|remove_bcc_headers\|undisclosed_recipients\|auto_from\) \(on$\|off$\)\@!.*$/
" Options which accept only an on/off/auto value.
syn match msmtpwrongoption /\<\(set_from_header\) \(on$\|off$\|auto$\)\@!.*$/
" Options which accept only an off/auto value.
syn match msmtpwrongoption /\<\(set_date_header\|set_msgid_header\) \(auto$\|off$\)\@!.*$/
" Option port accepts numeric values.
syn match msmtpwrongoption /\<\(port\|proxy_port\) \(\d\+$\)\@!.*$/
" Option timeout accepts off and numeric values.
syn match msmtpwrongoption /\<timeout \(off$\|\d\+$\)\@!.*$/
" Option protocol accepts smtp and lmtp.
syn match msmtpwrongoption /\<protocol \(smtp$\|lmtp$\)\@!.*$/
" Option auth accepts on, off and the method.
syn match msmtpwrongoption /\<auth \(on$\|off$\|plain$\|cram-md5$\|digest-md5$\|scram-sha-1$\|scram-sha-256$\|gssapi$\|external$\|login$\|ntlm$\|oauthbearer\|xoauth2\)\@!.*$/
" Option syslog accepts on, off and the facility.
syn match msmtpwrongoption /\<syslog \(on$\|off$\|LOG_USER$\|LOG_MAIL$\|LOG_LOCAL\d$\)\@!.*$/

" Marks all wrong option values as errors.
syn match msmtpwrongoptionvalue /\S* \zs.*$/ contained containedin=msmtpwrongoption

" Mark the option part as a normal option.
highlight default link msmtpwrongoption msmtpoption

" Email addresses
syntax match msmtpaddress /[a-z0-9_.-]*[a-z0-9]\+@[a-z0-9_.-]*[a-z0-9]\+\.[a-z]\+/
" Host names
syn match msmtphost /\%(host\s*\)\@<=\h\%(\w\|\.\|-\)*/
syn match msmtphost /\%(host\s*\)\@<=\%([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\)/
" Numeric values
syn match msmtpnumber /\<\(\d\+$\)/
" Strings
syntax region msmtpstring start=/"/ end=/"/
syntax region msmtpstring start=/'/ end=/'/
" Booleans
syntax match msmtpbool /\s\@<=\(on\|off\)$/

highlight default link msmtpcomment          Comment
highlight default link msmtpoption           Type
highlight default link msmtpwrongoptionvalue Error
highlight default link msmtpstring           String
highlight default link msmtpaddress          Constant
highlight default link msmtpnumber           Number
highlight default link msmtphost             Identifier
highlight default link msmtpbool             Constant

let &cpo = s:keepcpo
unlet s:keepcpo

let b:current_syntax = "msmtp"
