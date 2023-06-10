" Vim syntax file
" Language: mbsync configuration

if exists("b:current_syntax")
	finish
endif

let s:keepcpo = &cpo
set cpo&vim

syntax match mbserror    /.*/
syntax match mbscomment /^#.*$/ contains=@Spell

" -- Properties
syntax match   mbsnumber        /[0-9]\+/ display contained
syntax match   mbspath          /\%([A-Za-z0-9/._+#$%~=\\{}\[\]:@!-]\|\\.\)\+/ display contained
syntax match   mbspath          /"\%([A-Za-z0-9/._+#$%~=\\{}\[\]:@! -]\|\\.\)\+"/ display contained
syntax match   mbsname          /\%([A-Za-z0-9/._+#$%~=\\{}\[\]:@!-]\|\\.\)\+/ display contained
syntax match   mbsname          /"\%([A-Za-z0-9/._+#$%~=\\{}\[\]:@! -]\|\\.\)\+"/ display contained
syntax match   mbscommand       /+\?.*$/ display contained contains=mbscommandprompt
syntax match   mbscommandprompt /+/ display contained
syntax region  mbsstring        start=+"+ skip=+\\"+ end=+"+ display contained
syntax match   mbssizeunit      /[kKmMbB]/ display contained
syntax match   mbssize          /[0-9]\+/ display contained contains=mbsnumber nextgroup=mbssizeunit
syntax keyword mbsbool          yes no contained

" -- Stores
" --- Global Store Config Items
syntax match   mbsglobconfpath     /^Path\s\+\ze.*$/           contains=mbsglobconfitemk contained nextgroup=mbspath transparent
syntax match   mbsglobconfmaxsize  /^MaxSize\s\+\ze.*$/        contains=mbsglobconfitemk contained nextgroup=mbssize transparent
syntax match   mbsglobconfmapinbox /^MapInbox\s\+\ze.*$/       contains=mbsglobconfitemk contained nextgroup=mbspath transparent
syntax match   mbsglobconfflatten  /^Flatten\s\+\ze.*$/        contains=mbsglobconfitemk contained nextgroup=mbspath transparent
syntax match   mbsglobconftrash    /^Trash\s\+\ze.*$/          contains=mbsglobconfitemk contained nextgroup=mbspath transparent
syntax match   mbsglobconftrashno  /^TrashNewOnly\s\+\ze.*$/   contains=mbsglobconfitemk contained nextgroup=mbsbool transparent
syntax match   mbsglobconftrashrn  /^TrashRemoteNew\s\+\ze.*$/ contains=mbsglobconfitemk contained nextgroup=mbsbool transparent
syntax keyword mbsglobconfitemk    Path MaxSize MapInbox Flatten Trash TrashNewOnly TrashRemoteNew contained

syntax cluster mbsglobconfitem contains=mbsglobconfpath,mbsglobconfmaxsize,mbsglobconfmapinbox,mbsglobconfflatten,mbscomment,mbsglobconftrash.*


" --- MaildirStore
syntax match   mbsmdsconfstmaildirstore  /^MaildirStore\s\+\ze.*$/   contains=mbsmdsconfitemk contained nextgroup=mbsname transparent
syntax match   mbsmdsconfstaltmap        /^AltMap\s\+\ze.*$/         contains=mbsmdsconfitemk contained nextgroup=mbsbool transparent
syntax match   mbsmdsconfstinbox         /^Inbox\s\+\ze.*$/          contains=mbsmdsconfitemk contained nextgroup=mbspath transparent
syntax match   mbsmdsconfstinfodelimiter /^InfoDelimiter\s\+\ze.*$/  contains=mbsmdsconfitemk contained nextgroup=mbspath transparent
syntax keyword mbsmdsconfsubfoldersopt   verbatim Legacy contained
syntax match   mbsmdsconfsubfoldersopt   /Maildir++/ display contained
syntax match   mbsmdsconfstsubfolders    /^SubFolders\s\+\ze.*$/     contains=mbsmdsconfitemk contained nextgroup=mbsmdsconfsubfoldersopt transparent

syntax cluster mbsmdsconfitem contains=mbsmdsconfst.*

syntax keyword mbsmdsconfitemk   MaildirStore AltMap Inbox InfoDelimiter SubFolders contained

syntax region mbsmaildirstore start=/^MaildirStore/ end=/^$/ end=/\%$/ contains=@mbsglobconfitem,mbscomment,@mbsmdsconfitem,mbserror transparent


" --- IMAP4Accounts
syntax match mbsiaconfstimapaccount        /^IMAPAccount\s\+\ze.*$/         contains=mbsiaconfitemk contained nextgroup=mbsname    transparent
syntax match mbsiaconfsthost               /^Host\s\+\ze.*$/                contains=mbsiaconfitemk contained nextgroup=mbspath    transparent
syntax match mbsiaconfstport               /^Port\s\+\ze.*$/                contains=mbsiaconfitemk contained nextgroup=mbsnumber  transparent
syntax match mbsiaconfsttimeout            /^Timeout\s\+\ze.*$/             contains=mbsiaconfitemk contained nextgroup=mbsnumber  transparent
syntax match mbsiaconfstuser               /^User\s\+\ze.*$/                contains=mbsiaconfitemk contained nextgroup=mbspath    transparent
syntax match mbsiaconfstusercmd            /^UserCmd\s\+\ze.*$/             contains=mbsiaconfitemk contained nextgroup=mbscommand transparent
syntax match mbsiaconfstpass               /^Pass\s\+\ze.*$/                contains=mbsiaconfitemk contained nextgroup=mbspath    transparent
syntax match mbsiaconfstpasscmd            /^PassCmd\s\+\ze.*$/             contains=mbsiaconfitemk contained nextgroup=mbscommand transparent
syntax match mbsiaconfstusekeychain        /^UseKeychain\s\+\ze.*$/         contains=mbsiaconfitemk contained nextgroup=mbsbool    transparent
syntax match mbsiaconfsttunnel             /^Tunnel\s\+\ze.*$/              contains=mbsiaconfitemk contained nextgroup=mbscommand transparent
syntax match mbsiaconfstauthmechs          /^AuthMechs\s\+\ze.*$/           contains=mbsiaconfitemk contained nextgroup=mbspath    transparent
syntax keyword mbsiaconfssltypeopt         None STARTTLS IMAPS contained
syntax match mbsiaconfstssltype            /^SSLType\s\+\ze.*$/             contains=mbsiaconfitemk contained nextgroup=mbsiaconfssltypeopt     transparent
syntax match mbsiaconfsslversionsopt       /\%(SSLv3\|TLSv1\%(.[123]\)\?\)\%(\s\+\%(SSLv3\|TLSv1\%(.[123]\)\?\)\)*/ contained
syntax match mbsiaconfstsslversions        /^SSLVersions\s\+\ze.*$/         contains=mbsiaconfitemk contained nextgroup=mbsiaconfsslversionsopt transparent
syntax match mbsiaconfstsystemcertificates /^SystemCertificates\s\+\ze.*$/  contains=mbsiaconfitemk contained nextgroup=mbsbool                 transparent
syntax match mbsiaconfstcertificatefile    /^CertificateFile\s\+\ze.*$/     contains=mbsiaconfitemk contained nextgroup=mbspath                 transparent
syntax match mbsiaconfstclientcertificate  /^ClientCertificate\s\+\ze.*$/   contains=mbsiaconfitemk contained nextgroup=mbspath                 transparent
syntax match mbsiaconfstclientkey          /^ClientKey\s\+\ze.*$/           contains=mbsiaconfitemk contained nextgroup=mbspath                 transparent
syntax match mbsiaconfstcipherstring       /^CipherString\s\+\ze.*$/        contains=mbsiaconfitemk contained nextgroup=mbsstring               transparent
syntax match mbsiaconfstpipelinedepth      /^PipelineDepth\s\+\ze.*$/       contains=mbsiaconfitemk contained nextgroup=mbsnumber               transparent
syntax match mbsiaconfstdisableextensions  /^DisableExtensions\?\s\+\ze.*$/ contains=mbsiaconfitemk contained nextgroup=mbspath                 transparent

syntax cluster mbsiaconfitem contains=mbsiaconfst.*

syntax keyword mbsiaconfitemk
			\ IMAPAccount Host Port Timeout User UserCmd Pass PassCmd UseKeychain Tunnel
			\ AuthMechs SSLType SSLVersions SystemCertificates CertificateFile ClientCertificate
			\ ClientKey CipherString PipelineDepth DisableExtension[s] contained

syntax region mbsimap4accontsstore start=/^IMAPAccount/ end=/^$/ end=/\%$/ contains=@mbsglobconfitem,mbscomment,@mbsiaconfitem,mbserror transparent


" --- IMAPStores
syntax match mbsisconfstimapstore      /^IMAPStore\s\+\ze.*$/      contains=mbsisconfitemk contained nextgroup=mbsname transparent
syntax match mbsisconfstaccount        /^Account\s\+\ze.*$/        contains=mbsisconfitemk contained nextgroup=mbsname transparent
syntax match mbsisconfstusenamespace   /^UseNamespace\s\+\ze.*$/   contains=mbsisconfitemk contained nextgroup=mbsbool transparent
syntax match mbsisconfstpathdelimiter  /^PathDelimiter\s\+\ze.*$/  contains=mbsisconfitemk contained nextgroup=mbspath transparent
syntax match mbsisconfstsubscribedonly /^SubscribedOnly\s\+\ze.*$/ contains=mbsisconfitemk contained nextgroup=mbsbool transparent

syntax cluster mbsisconfitem contains=mbsisconfst.*

syntax keyword mbsisconfitemk  IMAPStore Account UseNamespace PathDelimiter SubscribedOnly contained

syntax region mbsimapstore start=/^IMAPStore/ end=/^$/ end=/\%$/ contains=@mbsglobconfitem,mbscomment,@mbsisconfitem,mbserror transparent

" -- Channels
syntax match   mbscconfstchannel       /^Channel\s\+\ze.*$/        contains=mbscconfitemk contained nextgroup=mbsname transparent
syntax region  mbscconfproxopt matchgroup=mbscconfproxoptop start=/:/ matchgroup=mbscconfproxoptop end=/:/ contained contains=mbsname nextgroup=mbspath keepend
syntax match   mbscconfstfar           /^Far\s\+\ze.*$/            contains=mbscconfitemk contained nextgroup=mbscconfproxopt transparent
syntax match   mbscconfstnear          /^Near\s\+\ze.*$/           contains=mbscconfitemk contained nextgroup=mbscconfproxopt transparent
syntax match   mbscconfpatternoptop /[*%!]/ display contained
syntax match   mbscconfpatternopt  /.*$/ display contained contains=mbscconfpatternoptop
syntax match   mbscconfstpattern       /^Patterns\?\s\+\ze.*$/     contains=mbscconfitemk contained nextgroup=mbscconfpatternopt transparent
syntax match   mbscconfstmaxsize       /^MaxSize\s\+\ze.*$/        contains=mbscconfitemk contained nextgroup=mbssize transparent
syntax match   mbscconfstmaxmessages   /^MaxMessages\s\+\ze.*$/    contains=mbscconfitemk contained nextgroup=mbsnumber transparent
syntax match   mbscconfstexpireunread  /^ExpireUnread\s\+\ze.*$/   contains=mbscconfitemk contained nextgroup=mbsbool transparent
syntax match   mbscconfsyncopt /None\|All\|\%(\s\+\%(Pull\|Push\|New\|ReNew\|Delete\|Flags\)\)\+/ display contained
syntax match   mbscconfstsync          /^Sync\s\+\ze.*$/           contains=mbscconfitemk contained nextgroup=mbscconfsyncopt transparent
syntax keyword mbscconfmanipopt  None Far Near Both contained
syntax match   mbscconfstcreate        /^Create\s\+\ze.*$/         contains=mbscconfitemk contained nextgroup=mbscconfmanipopt transparent
syntax match   mbscconfstremove        /^Remove\s\+\ze.*$/         contains=mbscconfitemk contained nextgroup=mbscconfmanipopt transparent
syntax match   mbscconfstexpunge       /^Expunge\s\+\ze.*$/        contains=mbscconfitemk contained nextgroup=mbscconfmanipopt transparent
syntax match   mbscconfstcopyarrivaldate /^CopyArrivalDate\s\+\ze.*$/ contains=mbscconfitemk contained nextgroup=mbsbool transparent
syntax match   mbscconfsyncstateopt  /\*\|.*$/ display contained contains=mbscconfsyncstateoptop,mbspath transparent
syntax match   mbscconfsyncstateoptop  /\*/ display contained
syntax match   mbscconfstsyncstate     /^SyncState\s\+\ze.*$/      contains=mbscconfitemk contained nextgroup=mbscconfsyncstateopt transparent

syntax cluster mbscconfitem contains=mbscconfst.*

syntax keyword mbscconfitemk
			\ Channel Far Near Pattern[s] MaxSize MaxMessages ExpireUnread Sync Create
			\ Remove Expunge CopyArrivalDate SyncState contained

syntax region mbschannel start=/^Channel/ end=/^$/ end=/\%$/ contains=@mbscconfitem,mbscomment,mbserror transparent

" -- Groups
syntax match mbsgconfgroupopt   /\%([A-Za-z0-9/._+#$%~=\\{}\[\]:@!-]\|\\.\)\+/ display contained contains=mbsname nextgroup=mbsgconfchannelopt
syntax match mbsgconfstgroup    /^Group\s\+\ze.*$/          contains=mbsgconfitemk contained nextgroup=mbsgconfgroupopt transparent
syntax match mbsgconfchannelopt /.*$/ display contained
syntax match mbsgconfstchannel  /^Channels\?\s\+\ze.*$/     contains=mbsgconfitemk contained nextgroup=mbsgconfchannelopt transparent

syntax cluster mbsgconfitem contains=mbsgconfst.*

syntax keyword mbsgconfitemk  Group Channel[s] contained

syntax region mbsgroup start=/^Group/ end=/^$/ end=/\%$/ contains=@mbsgconfitem,mbserror transparent

" -- Global Options

syntax match mbsfsync          /^FSync\s\+\ze.*$/          contains=mbsgloboptitemk nextgroup=mbsbool transparent
syntax match mbsfielddelimiter /^FieldDelimiter\s\+\ze.*$/ contains=mbsgloboptitemk nextgroup=mbspath transparent
syntax match mbsbufferlimit    /^BufferLimit\s\+\ze.*$/    contains=mbsgloboptitemk nextgroup=mbssize transparent

syntax keyword mbsgloboptitemk FSync FieldDelimiter BufferLimit contained

" -- Highlights
hi def link mbsbool                 Boolean
hi def link mbscconfitemk           Statement
hi def link mbscconfmanipopt        Keyword
hi def link mbscconfpatternopt      String
hi def link mbscconfpatternoptop    Operator
hi def link mbscconfproxoptop       Operator
hi def link mbscconfsyncopt         Keyword
hi def link mbscconfsyncstateoptop  Operator
hi def link mbscommand              String
hi def link mbscommandprompt        Operator
hi def link mbscomment              Comment
hi def link mbserror                Error
hi def link mbsgconfchannelopt      String
hi def link mbsgconfitemk           Statement
hi def link mbsglobconfitemk        Statement
hi def link mbsgloboptitemk         Statement
hi def link mbsiaconfitemk          Statement
hi def link mbsiaconfssltypeopt     Keyword
hi def link mbsiaconfsslversionsopt Keyword
hi def link mbsisconfitemk          Statement
hi def link mbsmdsconfitemk         Statement
hi def link mbsmdsconfsubfoldersopt Keyword
hi def link mbsname                 Constant
hi def link mbsnumber               Number
hi def link mbspath                 String
hi def link mbssizeunit             Type
hi def link mbsstring               String

let &cpo = s:keepcpo
unlet s:keepcpo

let b:current_syntax = "mbsync"
