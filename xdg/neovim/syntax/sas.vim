" Vim syntax file
" Language: SAS

" for version 5.x: clear all syntax items
" for later versions: quit when a syntax file was already loaded
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

let s:keepcpo = &cpo
set cpo&vim

syntax case ignore

" basic keywords
syntax keyword sasoperator and eq ge gt in le lt ne not of or
syntax keyword sasreserved _data_ _last_ _null_

" strings
syntax region sasstring start=+'+ skip=+''+ end=+'+ contains=@Spell
syntax region sasstring start=+"+ skip=+""+ end=+"+ contains=sasmacrovariable,@Spell

" constants
syntax match sasnumber   /\v<\d+%(\.\d+)=%(>|e[\-+]=\d+>)/ display
syntax match sasdatetime /\v(['"])\d{2}%(jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)\d{2}%(\d{2})=:\d{2}:\d{2}%(:\d{2})=%(am|pm)\1dt>/ display
syntax match sasdatetime /\v(['"])\d{2}%(jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)\d{2}%(\d{2})=\1d>/ display
syntax match sasdatetime /\v(['"])\d{2}:\d{2}%(:\d{2})=%(am|pm)\1t>/ display

" comments
syntax keyword sastodo    todo tbd fixme contained
syntax region  sascomment start="/\*" end="\*/" contains=sastodo
syntax region  sascomment start="\v%(^|;)\s*\zs\%=\*" end=";"me=s-1 contains=sastodo
syntax region  sassectlbl matchgroup=sassectlblends start="/\*\*\s*" end="\s*\*\*/" concealends

" macros
syntax match  sasmacrovariable "\v\&+\w+%(\.\w+)=" display
syntax match  sasmacroreserved "\v\%%(abort|by|copy|display|do|else|end|global|goto|if|include|input|let|list|local|macro|mend|put|return|run|symdel|syscall|sysexec|syslput|sysrput|then|to|until|window|while)>" display
syntax region sasmacrofunction matchgroup=sasmacrofunctionname start='\v\%\w+\ze\(' end=')'he=s-1 contains=@sasbasicsyntax,sasmacrofunction
syntax region sasmacrofunction matchgroup=sasmacrofunctionname start='\v\%q=sysfunc\ze\(' end=')'he=s-1 contains=@sasbasicsyntax,sasmacrofunction,sasdatastepfunction

" syntax cluster for basic syntaxes
syntax cluster sasbasicsyntax contains=sasoperator,sasreserved,sasnumber,sasdatetime,sasstring,sascomment,sasmacroreserved,sasmacrofunction,sasmacrovariable,sassectlbl

" formats
syntax match  sasformat        "\v\$\w+\." display contained
syntax match  sasformat        "\v<\w+\.%(\d+>)=" display contained
syntax region sasformatcontext start="." end=";"me=s-1 contained contains=@sasbasicsyntax,sasformat

" define global statements that can be accessed out of data step
" or procedures
syntax keyword sasglobalstatementkeyword    catname dm endsas filename footnote footnote1 footnote2 footnote3 footnote4 footnote5 footnote6 footnote7 footnote8 footnote9 footnote10 missing libname lock ods options page quit resetline run sasfile skip sysecho title title1 title2 title3 title4 title5 title6 title7 title8 title9 title10 contained
syntax keyword sasglobalstatementodskeyword chtml csvall docbook document escapechar epub epub2 epub3 exclude excel graphics html html3 html5 htmlcss imode listing markup output package path pcl pdf preferences phtml powerpoint printer proclabel proctitle ps results rtf select show tagsets trace usegopt verify wml contained
syntax match   sasglobalstatement           "\v%(^|;)\s*\zs\h\w*>" display transparent contains=sasglobalstatementkeyword
syntax match   sasglobalstatement           "\v%(^|;)\s*\zsods>" display transparent contains=sasglobalstatementkeyword nextgroup=sasglobalstatementodskeyword skipwhite skipnl skipempty

" data step statements, 9.4
syntax keyword sasdatastepautovariable          _n_ _error_ _infile_ _all_ _character_ _numeric_ _temporary_ contained
syntax keyword sasdatastepfunctionname          abs addr addrlong airy allcomb allperm anyalnum anyalpha anycntrl anydigit anyfirst anygraph anylower anyname anyprint anypunct anyspace anyupper anyxdigit arcos arcosh arsin arsinh artanh atan atan2 attrc attrn band beta betainv blackclprc blackptprc blkshclprc blkshptprc blshift bnot bor brshift bxor byte cat catq cats catt catx cdf ceil ceilz cexist char choosec choosen cinv close cmiss cnonct coalesce coalescec collate comb compare compbl compfuzz compged complev compound compress constant convx convxp cos cosh cot count countc countw csc css cumipmt cumprinc curobs cv daccdb daccdbsl daccsl daccsyd dacctab dairy datdif date datejul datepart datetime day dclose dcreate depdb depdbsl depsl depsyd deptab dequote deviance dhms dif digamma dim dinfo divide dnum dopen doptname doptnum dosubl dread dropnote dsname dsncatlgd dur durp effrate envlen erf erfc euclid exist exp fact fappend fclose fcol fcopy fdelete fetch fetchobs fexist fget fileexist filename fileref finance find findc findw finfo finv fipname fipnamel fipstate first floor floorz fmtinfo fnonct fnote fopen foptname foptnum fpoint fpos fput fread frewind frlen fsep fuzz fwrite gaminv gamma garkhclprc garkhptprc gcd geodist geomean geomeanz getoption getvarc getvarn graycode harmean harmeanz hbound hms holiday holidayck holidaycount holidayname holidaynx holidayny holidaytest hour htmldecode htmlencode ibessel ifc ifn index indexc indexw input inputc inputn int intcindex intck intcycle intfit intfmt intget intindex intnx intrr intseas intshift inttest intz iorcmsg ipmt iqr irr jbessel juldate juldate7 kurtosis lag largest lbound lcm lcomb left length lengthc lengthm lengthn lexcomb lexcombi lexperk lexperm lfact lgamma libname libref log log1px log10 log2 logbeta logcdf logistic logpdf logsdf lowcase lperm lpnorm mad margrclprc margrptprc max md5 mdy mean median min minute missing mod modexist module modulec modulen modz month mopen mort msplint mvalid contained
syntax keyword sasdatastepfunctionname          n netpv nliteral nmiss nomrate normal notalnum notalpha notcntrl notdigit note notfirst notgraph notlower notname notprint notpunct notspace notupper notxdigit npv nvalid nwkdom open ordinal pathname pctl pdf peek peekc peekclong peeklong perm pmt point poisson ppmt probbeta probbnml probbnrm probchi probf probgam probhypr probit probmc probnegb probnorm probt propcase prxchange prxmatch prxparen prxparse prxposn ptrlongadd put putc putn pvp qtr quantile quote ranbin rancau rand ranexp rangam range rank rannor ranpoi rantbl rantri ranuni rename repeat resolve reverse rewind right rms round rounde roundz saving savings scan sdf sec second sha256 sha256hex sha256hmachex sign sin sinh skewness sleep smallest soapweb soapwebmeta soapwipservice soapwipsrs soapws soapwsmeta soundex spedis sqrt squantile std stderr stfips stname stnamel strip subpad substr substrn sum sumabs symexist symget symglobl symlocal sysexist sysget sysmsg sysparm sysprocessid sysprocessname sysprod sysrc system tan tanh time timepart timevalue tinv tnonct today translate transtrn tranwrd trigamma trim trimn trunc tso typeof tzoneid tzonename tzoneoff tzones2u tzoneu2s uniform upcase urldecode urlencode uss uuidgen var varfmt varinfmt varlabel varlen varname varnum varray varrayx vartype verify vformat vformatd vformatdx vformatn vformatnx vformatw vformatwx vformatx vinarray vinarrayx vinformat vinformatd vinformatdx vinformatn vinformatnx vinformatw vinformatwx vinformatx vlabel vlabelx vlength vlengthx vname vnamex vtype vtypex vvalue vvaluex week weekday whichc whichn wto year yieldp yrdif yyq zipcity zipcitydistance zipfips zipname zipnamel zipstate contained
syntax keyword sasdatastepcallroutinename       allcomb allcombi allperm cats catt catx compcost execute graycode is8601_convert label lexcomb lexcombi lexperk lexperm logistic missing module poke pokelong prxchange prxdebug prxfree prxnext prxposn prxsubstr ranbin rancau rancomb ranexp rangam rannor ranperk ranperm ranpoi rantbl rantri ranuni scan set sleep softmax sortc sortn stdize streaminit symput symputx system tanh tso vname vnext wto contained
syntax region  sasdatastepfunctioncontext       start="(" end=")" contained contains=@sasbasicsyntax,sasdatastepfunction
syntax region  sasdatastepfunctionformatcontext start="(" end=")" contained contains=@sasbasicsyntax,sasdatastepfunction,sasformat
syntax match   sasdatastepfunction              "\v<\w+\ze\(" contained contains=sasdatastepfunctionname,sasdatastepcallroutinename nextgroup=sasdatastepfunctioncontext
syntax match   sasdatastepfunction              "\v%(input|put)\ze\(" contained contains=sasdatastepfunctionname nextgroup=sasdatastepfunctionformatcontext
syntax keyword sasdatastephashmethodname        add check clear definedata definedone definekey delete do_over equals find find_next find_prev first has_next has_prev last next output prev ref remove removedup replace replacedup reset_dup setcur sum sumdup contained
syntax region  sasdatastephashmethodcontext     start="(" end=")" contained contains=@sasbasicsyntax,sasdatastepfunction
syntax match   sasdatastephashmethod            "\v\.\w+\ze\(" contained contains=sasdatastephashmethodname nextgroup=sasdatastephashmethodcontext
syntax keyword sasdatastephashattributename     item_size num_items contained
syntax match   sasdatastephashattribute         "\v\.\w+>\ze\_[^(]" display contained contains=sasdatastephashattributename
syntax keyword sasdatastepcontrol               continue do end go goto if leave link otherwise over return select to until when while contained
syntax keyword sasdatastepcontrol               else then contained nextgroup=sasdatastepstatementkeyword skipwhite skipnl skipempty
syntax keyword sasdatastephashoperator          _new_ contained
syntax keyword sasdatastepstatementkeyword      abort array attrib by call cards cards4 datalines datalines4 dcl declare delete describe display drop error execute file format infile informat input keep label length lines lines4 list lostcard merge modify output put putlog redirect remove rename replace retain set stop update where window contained
syntax keyword sasdatastepstatementhashkeyword  hash hiter javaobj contained
syntax match   sasdatastepstatement             "\v%(^|;)\s*\zs\h\w*>" display contained contains=sasdatastepstatementkeyword,sasglobalstatementkeyword
syntax match   sasdatastepstatement             "\v%(^|;)\s*\zs%(dcl|declare)>" display contained contains=sasdatastepstatementkeyword nextgroup=sasdatastepstatementhashkeyword skipwhite skipnl skipempty
syntax match   sasdatastepstatement             "\v%(^|;)\s*\zsods>" display contained contains=sasglobalstatementkeyword nextgroup=sasglobalstatementodskeyword skipwhite skipnl skipempty
syntax match   sasdatastepstatement             "\v%(^|;)\s*\zs%(attrib|format|informat|input|put)>" display contained contains=sasdatastepstatementkeyword nextgroup=sasformatcontext skipwhite skipnl skipempty
syntax match   sasdatastepstatement             "\v%(^|;)\s*\zs%(cards|datalines|lines)4=\s*;" display contained contains=sasdatastepstatementkeyword nextgroup=sasdataline skipwhite skipnl skipempty
syntax region  sasdataline                      start="^" end="^\s*;"me=s-1 contained
syntax region  sasdatastep                      matchgroup=sassectionkeyword start="\v%(^|;)\s*\zsdata>" end="\v%(^|;)\s*%(run|data|proc|endsas)>"me=s-1 fold contains=@sasbasicsyntax,@sasdatastepsyntax
syntax cluster sasdatastepsyntax                contains=sasdatastepautovariable,sasdatastepfunction,sasdatastephashoperator,sasdatastephashattribute,sasdatastephashmethod,sasdatastepcontrol,sasdatastepstatement

" procedures, base, 9.4
syntax keyword sasprocstatementkeyword abort age append array attrib audit block break by calid cdfplot change checkbox class classlev column compute contents copy create datarow dbencoding define delete deletefunc deletesubr delimiter device dialog dur endcomp exact exchange exclude explore fin fmtlib fontfile fontpath format formats freq function getnames guessingrows hbar hdfs histogram holidur holifin holistart holivar id idlabel informat inset invalue item key keylabel keyword label line link listfunc listsubr mapmiss mapreduce mean menu messages meta modify opentype outargs outdur outfin output outstart pageby partial picture pie pig plot ppplot printer probplot profile prompter qqplot radiobox ranks rbreak rbutton rebuild record remove rename repair report roptions save select selection separator source star start statistics struct submenu subroutine sum sumby table tables test text trantab truetype type1 types value var vbar ways weight where with write contained
syntax match   sasprocstatement        "\v%(^|;)\s*\zs\h\w*>" display contained contains=sasprocstatementkeyword,sasglobalstatementkeyword
syntax match   sasprocstatement        "\v%(^|;)\s*\zsods>" display contained contains=sasglobalstatementkeyword nextgroup=sasglobalstatementodskeyword skipwhite skipnl skipempty
syntax match   sasprocstatement        "\v%(^|;)\s*\zs%(format|informat)>" display contained contains=sasprocstatementkeyword nextgroup=sasformatcontext skipwhite skipnl skipempty
syntax region  sasproc                 matchgroup=sassectionkeyword start="\v%(^|;)\s*\zsproc%(\s+\h\w*)=>" end="\v%(^|;)\s*%(run|data|proc|endsas)>"me=s-1 fold contains=@sasbasicsyntax,sasdatastepcontrol,sasdatastepfunction,sasprocstatement
syntax region  sasproc                 matchgroup=sassectionkeyword start="\v%(^|;)\s*\zsproc\s+%(catalog|chart|datasets|document|plot)>" end="\v%(^|;)\s*%(quit|data|proc|endsas)>"me=s-1 fold contains=@sasbasicsyntax,sasdatastepfunction,sasprocstatement

" procedures, sas/graph, 9.4
syntax keyword sasgraphprocstatementkeyword add area axis bar block bubble2 byline cc ccopy cdef cdelete chart cmap choro copy delete device dial donut exclude flow format fs goptions gout grid group hbar hbar3d hbullet hslider htrafficlight id igout label legend list modify move nobyline note pattern pie pie3d plot plot2 preview prism quit rename replay select scatter speedometer star surface symbol tc tcopy tdef tdelete template tile toggle treplay vbar vbar3d vtrafficlight vbullet vslider where contained
syntax match   sasgraphprocstatement        "\v%(^|;)\s*\zs\h\w*>" display contained contains=sasgraphprocstatementkeyword,sasglobalstatementkeyword
syntax match   sasgraphprocstatement        "\v%(^|;)\s*\zsformat>" display contained contains=sasgraphprocstatementkeyword nextgroup=sasformatcontext skipwhite skipnl skipempty
syntax region  sasgraphproc                 matchgroup=sassectionkeyword start="\v%(^|;)\s*\zsproc\s+%(g3d|g3grid|ganno|gcontour|gdevice|geocode|gfont|ginside|goptions|gproject|greduce|gremove|mapimport)>" end="\v%(^|;)\s*%(run|data|proc|endsas)>"me=s-1 fold contains=@sasbasicsyntax,sasdatastepfunction,sasgraphprocstatement
syntax region  sasgraphproc                 matchgroup=sassectionkeyword start="\v%(^|;)\s*\zsproc\s+%(gareabar|gbarline|gchart|gkpi|gmap|gplot|gradar|greplay|gslide|gtile)>" end="\v%(^|;)\s*%(quit|data|proc|endsas)>"me=s-1 fold contains=@sasbasicsyntax,sasdatastepfunction,sasgraphprocstatement

" procedures, sas/stat, 14.3
syntax keyword sasanalyticalprocstatementkeyword absorb add array assess baseline bayes beginnodata bivar bootstrap bounds by cdfplot cells class cluster code compute condition contrast control coordinates copy cosan cov covar covtest coxreg der design determ deviance direct directions domain effect effectplot effpart em endnodata equality estimate evaluate exact exactoptions factor factors fcs filter fitindex format freq fwdlink gender grid group grow hazardratio height hyperprior id impjoint inset insetgroup invar invlink ippplot lincon lineqs lismod lmtests location logistic loglin lpredplot lsmeans lsmestimate manova match matings matrix mcmc mean means mediator missmodel mnar model modelaverage modeleffects monotone mstruct mtest multreg name nlincon nloptions oddsratio onecorr onesamplefreq onesamplemeans onewayanova outfiles output paired pairedfreq pairedmeans parameters parent parms partial partition path pathdiagram pcov performance plot population poststrata power preddist predict predpplot priors process probmodel profile prune psdata psmodel psweight pvar ram random ratio reference refit refmodel renameparm repeated replicate repweights response restore restrict retain reweight ridge rmsstd roc roccontrast rules samplesize samplingunit seed size scale score selection show simtests simulate slice std stderr store strata structeq supplementary table tables test testclass testfreq testfunc testid time transform treatments trend twosamplefreq twosamplemeans towsamplesurvival twosamplewilcoxon uds units univar var variance varnames weight where with zeromodel contained
syntax match   sasanalyticalprocstatement        "\v%(^|;)\s*\zs\h\w*>" display contained contains=sasanalyticalprocstatementkeyword,sasglobalstatementkeyword
syntax match   sasanalyticalprocstatement        "\v%(^|;)\s*\zsods>" display contained contains=sasglobalstatementkeyword nextgroup=sasglobalstatementodskeyword skipwhite skipnl skipempty
syntax match   sasanalyticalprocstatement        "\v%(^|;)\s*\zsformat>" display contained contains=sasanalyticalprocstatementkeyword nextgroup=sasformatcontext skipwhite skipnl skipempty
syntax region  sasanalyticalproc                 matchgroup=sassectionkeyword start="\v%(^|;)\s*\zsproc\s+%(aceclus|adaptivereg|bchoice|boxplot|calis|cancorr|candisc|causalmed|causaltrt|cluster|corresp|discrim|distance|factor|fastclus|fmm|freq|gam|gampl|gee|genmod|glimmix|glmmod|glmpower|glmselect|hpcandisc|hpfmm|hpgenselect|hplmixed|hplogistic|hpmixed|hpnlmod|hppls|hpprincomp|hpquantselect|hpreg|hpsplit|iclifetest|icphreg|inbreed|irt|kde|krige2d|lattice|lifereg|lifetest|loess|logistic|mcmc|mds|mi|mianalyze|mixed|modeclus|multtest|nested|nlin|nlmixed|npar1way|orthoreg|phreg|plm|pls|power|princomp|prinqual|probit|psmatch|quantlife|quantreg|quantselect|robustreg|rsreg|score|seqdesign|seqtest|sim2d|simnormal|spp|stdize|stdrate|stepdisc|surveyfreq|surveyimpute|surveylogistic|surveymeans|surveyphreg|surveyreg|surveyselect|tpspline|transreg|tree|ttest|varclus|varcomp|variogram)>" end="\v%(^|;)\s*%(run|data|proc|endsas)>"me=s-1 fold contains=@sasbasicsyntax,sasdatastepcontrol,sasdatastepfunction,sasanalyticalprocstatement
syntax region  sasanalyticalproc                 matchgroup=sassectionkeyword start="\v%(^|;)\s*\zsproc\s+%(anova|arima|catmod|factex|glm|model|optex|plan|reg)>" end="\v%(^|;)\s*%(quit|data|proc|endsas)>"me=s-1 fold contains=@sasbasicsyntax,sasdatastepcontrol,sasdatastepfunction,sasanalyticalprocstatement

" procedures, ods graphics, 9.4
syntax keyword sasodsgraphicsprocstatementkeyword band block bubble by colaxis colaxistable compare dattrvar density dot dropline dynamic ellipse ellipseparm format fringe gradlegend hbar hbarbasic hbarparm hbox heatmap heatmapparm highlow histogram hline inset keylegend label lineparm loess matrix needle parent panelby pbspline plot polygon refline reg rowaxis rowaxistable scatter series spline step style styleattrs symbolchar symbolimage text vbar vbarbasic vbarparm vbox vector vline waterfall where xaxis x2axis yaxis y2axis yaxistable contained
syntax match   sasodsgraphicsprocstatement        "\v%(^|;)\s*\zs\h\w*>" display contained contains=sasodsgraphicsprocstatementkeyword,sasglobalstatementkeyword
syntax match   sasodsgraphicsprocstatement        "\v%(^|;)\s*\zsods>" display contained contains=sasglobalstatementkeyword nextgroup=sasglobalstatementodskeyword skipwhite skipnl skipempty
syntax match   sasodsgraphicsprocstatement        "\v%(^|;)\s*\zsformat>" display contained contains=sasodsgraphicsprocstatementkeyword nextgroup=sasformatcontext skipwhite skipnl skipempty
syntax region  sasodsgraphicsproc                 matchgroup=sassectionkeyword start="\v%(^|;)\s*\zsproc\s+%(sgdesign|sgpanel|sgplot|sgrender|sgscatter)>" end="\v%(^|;)\s*%(run|data|proc|endsas)>"me=s-1 fold contains=@sasbasicsyntax,sasdatastepfunction,sasodsgraphicsprocstatement

" proc template, 9.4
syntax keyword sasproctemplateclause                  as into
syntax keyword sasproctemplatestatementkeyword        block break cellstyle class close column compute continue define delete delstream do done dynamic edit else end endif eval flush footer header if import iterate link list mvar ndent next nmvar notes open path put putl putlog putq putstream putvars replace set source stop style test text text2 text3 translate trigger unblock unset xdent contained
syntax keyword sasproctemplatestatementcomplexkeyword cellvalue column crosstabs event footer header statgraph style table tagset contained
syntax keyword sasproctemplategtlstatementkeyword     axislegend axistable bandplot barchart barchartparm begingraph beginpolygon beginpolyline bihistogram3dparm blockplot boxplot boxplotparm bubbleplot continuouslegend contourplotparm dendrogram discreteattrmap discreteattrvar discretelegend drawarrow drawimage drawline drawoval drawrectangle drawtext dropline ellipse ellipseparm enddiscreteattrmap endgraph endinnermargin endlayout endpolygon endpolyline endsidebar entry entryfootnote entrytitle fringeplot heatmap heatmapparm highlowplot histogram histogramparm innermargin layout legenditem legendtextitems linechart lineparm loessplot mergedlegend modelband needleplot pbsplineplot polygonplot referenceline regressionplot scatterplot seriesplot sidebar stepplot surfaceplotparm symbolchar symbolimage textplot value vectorplot waterfallchart contained
syntax keyword sasproctemplategtlcomplexkeyword       datalattice datapanel globallegend gridded lattice overlay overlayequated overlay3d region contained
syntax match   sasproctemplatestatement               "\v%(^|;)\s*\zs\h\w*>" display contained contains=sasproctemplatestatementkeyword,sasproctemplategtlstatementkeyword,sasglobalstatementkeyword
syntax match   sasproctemplatestatement               "\v%(^|;)\s*\zsdefine>" display contained contains=sasproctemplatestatementkeyword nextgroup=sasproctemplatestatementcomplexkeyword skipwhite skipnl skipempty
syntax match   sasproctemplatestatement               "\v%(^|;)\s*\zslayout>" display contained contains=sasproctemplategtlstatementkeyword nextgroup=sasproctemplategtlcomplexkeyword skipwhite skipnl skipempty
syntax match   sasproctemplatestatement               "\v%(^|;)\s*\zsods>" display contained contains=sasglobalstatementkeyword nextgroup=sasglobalstatementodskeyword skipwhite skipnl skipempty
syntax region  sasproctemplate                        matchgroup=sassectionkeyword start="\v%(^|;)\s*\zsproc\s+template>" end="\v%(^|;)\s*%(run|data|proc|endsas)>"me=s-1 fold contains=@sasbasicsyntax,sasproctemplateclause,sasproctemplatestatement

" proc sql, 9.4
syntax keyword sasprocsqlfunctionname            avg count css cv freq max mean median min n nmiss prt range std stderr sum sumwgt t uss var contained
syntax region  sasprocsqlfunctioncontext         start="(" end=")" contained contains=@sasbasicsyntax,sasprocsqlfunction
syntax match   sasprocsqlfunction                "\v<\w+\ze\(" contained contains=sasprocsqlfunctionname,sasdatastepfunctionname nextgroup=sasprocsqlfunctioncontext
syntax keyword sasprocsqlclause                  add asc between by calculated cascade case check connection constraint cross desc distinct drop else end escape except exists foreign from full group having in inner intersect into is join key left libname like modify natural newline notrim null on order outer primary references restrict right separated set then through thru to trimmed union unique user using values when where contained
syntax keyword sasprocsqlclause                  as contained nextgroup=sasprocsqlstatementkeyword skipwhite skipnl skipempty
syntax keyword sasprocsqlstatementkeyword        connect delete disconnect execute insert reset select update validate contained
syntax keyword sasprocsqlstatementcomplexkeyword alter create describe drop contained nextgroup=sasprocsqlstatementnextkeyword skipwhite skipnl skipempty
syntax keyword sasprocsqlstatementnextkeyword    index table view contained
syntax match   sasprocsqlstatement               "\v%(^|;)\s*\zs\h\w*>" display contained contains=sasprocsqlstatementkeyword,sasglobalstatementkeyword
syntax match   sasprocsqlstatement               "\v%(^|;)\s*\zs%(alter|create|describe|drop)>" display contained contains=sasprocsqlstatementcomplexkeyword nextgroup=sasprocsqlstatementnextkeyword skipwhite skipnl skipempty
syntax match   sasprocsqlstatement               "\v%(^|;)\s*\zsvalidate>" display contained contains=sasprocsqlstatementkeyword nextgroup=sasprocsqlstatementkeyword,sasprocsqlstatementcomplexkeyword skipwhite skipnl skipempty
syntax match   sasprocsqlstatement               "\v%(^|;)\s*\zsods>" display contained contains=sasglobalstatementkeyword nextgroup=sasglobalstatementodskeyword skipwhite skipnl skipempty
syntax region  sasprocsql                        matchgroup=sassectionkeyword start="\v%(^|;)\s*\zsproc\s+sql>" end="\v%(^|;)\s*%(quit|data|proc|endsas)>"me=s-1 fold contains=@sasbasicsyntax,sasprocsqlfunction,sasprocsqlclause,sasprocsqlstatement

" sas/ds2, 9.4
syntax keyword sasds2functionname            abs anyalnum anyalpha anycntrl anydigit anyfirst anygraph anylower anyname anyprint anypunct anyspace anyupper anyxdigit arcos arcosh arsin arsinh artanh atan atan2 band beta betainv blackclprc blackptprc blkshclprc blkshptprc blshift bnot bor brshift bxor byte cat cats catt catx ceil ceilz choosec choosen cmp cmpt coalesce coalescec comb compare compbl compfuzz compound compress constant convx convxp cos cosh count countc countw css cumipmt cumprinc cv datdif date datejul datepart datetime day dequote deviance dhms dif digamma dim divide dur durp effrate erf erfc exp fact find findc findw floor floorz fmtinfo fuzz gaminv gamma garkhclprc garkhptprc gcd geodist geomean geomeanz harmean harmeanz hbound hms holiday hour index indexc indexw inputc inputn int intcindex intck intcycle intdt intfit intget intindex intnest intnx intrr intseas intshift inttest intts intz ipmt iqr irr juldate juldate7 kcount kstrcat kstrip kupdate kupdates kurtosis lag largest lbound lcm left length lengthc lengthm lengthn lgamma log logbeta log10 log1px log2 lowcase mad margrclprc margrptprc max md5 mdy mean median min minute missing mod modz month mort n ndims netpv nmiss nomrate notalnum notalpha notcntrl notdigit notfirst notgraph notlower notname notprint notpunct notspace notupper notxdigit npv null nwkdom ordinal pctl perm pmt poisson power ppmt probbeta probbnml probbnrm probchi probdf probf probgam probhypr probit probmc probmed probnegb probnorm probt prxchange prxmatch prxparse prxposn put pvp qtr quote ranbin rancau rand ranexp rangam range rank rannor ranpoi rantbl rantri ranuni repeat reverse right rms round rounde roundz savings scan sec second sha256hex sha256hmachex sign sin sinh skewness sleep smallest sqlexec sqrt std stderr streaminit strip substr substrn sum sumabs tan tanh time timepart timevalue tinv to_date to_double to_time to_timestamp today translate transtrn tranwrd trigamma trim trimn trunc uniform upcase uss uuidgen var verify vformat vinarray vinformat vlabel vlength vname vtype week weekday whichc whichn year yieldp yrdif yyq contained
syntax region  sasds2functioncontext         start="(" end=")" contained contains=@sasbasicsyntax,sasds2function
syntax match   sasds2function                "\v<\w+\ze\(" contained contains=sasds2functionname nextgroup=sasds2functioncontext
syntax keyword sasds2control                 continue data dcl declare do drop else end enddata endpackage endthread from go goto if leave method otherwise package point return select then thread to until when while contained
syntax keyword sasds2statementkeyword        array by forward keep merge output put rename retain set stop vararray varlist contained
syntax keyword sasds2statementcomplexkeyword package thread contained
syntax match   sasds2statement               "\v%(^|;)\s*\zs\h\w*>" display contained contains=sasds2statementkeyword,sasglobalstatementkeyword
syntax match   sasds2statement               "\v%(^|;)\s*\zs%(dcl|declare|drop)>" display contained contains=sasds2statementkeyword nextgroup=sasds2statementcomplexkeyword skipwhite skipnl skipempty
syntax match   sasds2statement               "\v%(^|;)\s*\zsods>" display contained contains=sasglobalstatementkeyword nextgroup=sasglobalstatementodskeyword skipwhite skipnl skipempty
syntax region  sasds2                        matchgroup=sassectionkeyword start="\v%(^|;)\s*\zsproc\s+ds2>" end="\v%(^|;)\s*%(quit|data|proc|endsas)>"me=s-1 fold contains=@sasbasicsyntax,sasds2function,sasds2control,sasds2statement

" sas/iml, 14.1
syntax keyword sasimlautovariable     _all_ _char_ _num_ contained
syntax keyword sasimlfunctionname     abs all allcomb allperm any apply armasim bin blankstr block branks bspline btran byte char choose col colvec concat contents convexit corr corr2cov countmiss countn countunique cov cov2corr covlag cshape cusum cuprod cv cvexhull datasets design designf det diag dif dimension distance do duration echelon eigval eigvec element exp expmatrix expandgrid fft fftc forward froot full gasetup geomean ginv hadamard half hankel harmean hdir hermite homogen i ifft ifftc importtablefromr insert int inv invupdt isempty isskipped j jroot kurtosis lag lambertw length listcreate listgetallnames listgetitem listgetname listgetsubitem listindex listlen loc log logabsdet mad magic mahalanobis max mean median min mod moduleic modulein name ncol ndx2sub nleng norm normal nrow num opscal orpol parentname palette polyroot prod product pv quartile rancomb randdirichlet randfun randmultinomial randmvt randnormal randwishart ranperk ranperm range rank ranktie rates ratio remove repeat root row rowcat rowcatc rowvec rsubstr sample setdif shape shapecol skewness solve sparse splinev spot sqrsym sqrt sqrvech ssq standard std storage sub2ndx substr sum sweep symsqr t tablecreate tablecreatefromdataset tablegetvardata tablegetvarformat tablegetvarindex tablegetvarinformat tablegetvarlabel tablegetvarname tablegetvartype tableisexistingvar tableisvarnumeric tfhilbert tfpwv tfstft tfwindow toeplitz trace trisolv type uniform union unique uniqueby value var vecdiag vech xmult xsect yield contained
syntax keyword sasimlcallroutinename  appcort armacov armalik bar box change comport delete eigen execute executefile exportdatasettor exportmatrixtor exporttabletor farmacov farmafit farmalik farmasim fdif gaend gagetmem gagetval gainit gareeval garegen gasetcro gasetmut gasetobj gasetsel geneig gscale gsorth heatmapcont heatmapdisc histogram importdatasetfromr importmatrixfromr ipf itsolver kalcvf kalcvs kaldff kaldfs lav lcp listadditem listdeleteitem listdeletename listinsertitem listsetitem listsetname listsetsubitem lms lp lpsolve lts lupdt marg maxqform mcd milpsolve modulei mve nlpcg nlpdd nlpfdd nlpfea nlphqn nlplm nlpnms nlpnra nlpnrr nlpqn nlpqua nlptr ode odsgraph ortvec push qntl qr quad queue randgen randseed rdodt rupdt rename rupdt rzlind scatter seq seqscale seqshift series solvelin sort sortndx sound spline splinec svd tableaddvar tableprint tablerenamevar tablesetvarformat tablesetvarinformat tablesetvarlabel tablewritetodataset tabulate tpspline tpsplnev tsbaysea tsdecomp tsmlocar tsmlomar tsmulmar tspears tspred tsroot tstvcar tsunimar valset varmacov varmalik varmasim vnormal vtsroot wavft wavget wavift wavprint wavthrsh widetolong contained
syntax region  sasimlfunctioncontext  start="(" end=")" contained contains=@sasbasicsyntax,sasimlfunction
syntax match   sasimlfunction         "\v<\w+\ze\(" contained contains=sasimlfunctionname,sasimlcallroutinename,sasdatastepfunction nextgroup=sasimlfunctioncontext
syntax keyword sasimlcontrol          abort by do else end endsubmit finish goto if link pause quit resume return run start stop submit then to until while contained
syntax keyword sasimlstatementkeyword append call close closefile create delete display edit file find force free index infile input list load mattrib print purge put read remove replace reset save setin setout show sort store summary use contained
syntax match   sasimlstatement        "\v%(^|;)\s*\zs\h\w*>" display contained contains=sasimlstatementkeyword,sasglobalstatementkeyword
syntax match   sasimlstatement        "\v%(^|;)\s*\zsods>" display contained contains=sasglobalstatementkeyword nextgroup=sasglobalstatementodskeyword skipwhite skipnl skipempty
syntax region  sasiml                 matchgroup=sassectionkeyword start="\v%(^|;)\s*\zsproc\s+iml>" end="\v%(^|;)\s*%(quit|endsas)>"me=s-1 fold contains=@sasbasicsyntax,sasimlautovariable,sasimlfunction,sasimlcontrol,sasimlstatement

" macro definition
syntax region sasmacro start="\v\%macro>" end="\v\%mend>" fold keepend contains=@sasbasicsyntax,@sasdatastepsyntax,sasdatastep,sasproc,sasodsgraphicsproc,sasgraphproc,sasanalyticalproc,sasproctemplate,sasprocsql,sasds2,sasiml

" define highlights
hi def link sascomment                             Comment
hi def link sastodo                                Delimiter
hi def link sassectlbl                             Title
hi def link sassectlblends                         Comment
hi def link sasnumber                              Number
hi def link sasdatetime                            Constant
hi def link sasstring                              String
hi def link sasdatastepcontrol                     Keyword
hi def link sasproctemplateclause                  Keyword
hi def link sasprocsqlclause                       Keyword
hi def link sasds2control                          Keyword
hi def link sasimlcontrol                          Keyword
hi def link sasoperator                            Operator
hi def link sasglobalstatementkeyword              Statement
hi def link sasglobalstatementodskeyword           Statement
hi def link sassectionkeyword                      Statement
hi def link sasdatastepfunctionname                Function
hi def link sasdatastepcallroutinename             Function
hi def link sasdatastepstatementkeyword            Statement
hi def link sasdatastepstatementhashkeyword        Statement
hi def link sasdatastephashoperator                Operator
hi def link sasdatastephashmethodname              Function
hi def link sasdatastepautovariable                Identifier
hi def link sasdatastephashattributename           Identifier
hi def link sasprocstatementkeyword                Statement
hi def link sasodsgraphicsprocstatementkeyword     Statement
hi def link sasgraphprocstatementkeyword           Statement
hi def link sasanalyticalprocstatementkeyword      Statement
hi def link sasproctemplatestatementkeyword        Statement
hi def link sasproctemplatestatementcomplexkeyword Statement
hi def link sasproctemplategtlstatementkeyword     Statement
hi def link sasproctemplategtlcomplexkeyword       Statement
hi def link sasprocsqlfunctionname                 Function
hi def link sasprocsqlstatementkeyword             Statement
hi def link sasprocsqlstatementcomplexkeyword      Statement
hi def link sasprocsqlstatementnextkeyword         Statement
hi def link sasds2functionname                     Function
hi def link sasds2statementkeyword                 Statement
hi def link sasimlautovariable                     Identifier
hi def link sasimlfunctionname                     Function
hi def link sasimlcallroutinename                  Function
hi def link sasimlstatementkeyword                 Statement
hi def link sasmacroreserved                       PreProc
hi def link sasmacrovariable                       Define
hi def link sasmacrofunctionname                   Define
hi def link sasdataline                            SpecialChar
hi def link sasformat                              SpecialChar
hi def link sasreserved                            Special

" synchronize from beginning to keep large blocks from losing
" syntax coloring while moving through code.
syntax sync fromstart

let &cpo = s:keepcpo
unlet s:keepcpo

let b:current_syntax = "sas"
