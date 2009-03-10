# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-latexextra/texlive-latexextra-2008-r1.ebuild,v 1.5 2009/03/10 19:44:39 armin76 Exp $

TEXLIVE_MODULE_CONTENTS="AkkTeX ESIEEcv GuIT HA-prosper Tabbing a0poster abstract achemso acronym addlines adrconv adrlist akletter altfont amsaddr animate answers anyfontsize appendix arcs arrayjob assignment attachfile authoraftertitle authorindex autotab beamer-contrib begriff beton bez123 bezos bigfoot binomexp bizcard blindtext blowup boites bookest booklet bophook boxhandler breakurl bullcntr bussproofs calrsfs calxxxx captcont casyl catechis cbcoptic ccaption cclicenses cd cd-cover cdpbundl cellspace changebar changepage changes chappg chapterfolder china2e chletter circ cjw clefval cleveref clock cmdstring cmdtrack cmsd codepage colorinfo colorwav combine comment concprog constants contour cooking cool coollist coolstr cooltooltips coordsys courseoutline coursepaper coverpage crossreference crosswrd csquotes csvtools cuisine cursor cv cweb-latex cwpuzzle dashbox dashrule datatool dateiliste datenumber datetime decimal delimtxt diagnose dialogl dichokey dinbrief directory dlfltxb dnaseq docmfp doi dotarrow dotseqn dpfloat dprogress drac draftcopy draftwatermark dtk dtxgallery dvdcoll eCards easy ean13isbn ebezier ecclesiastic ecv ed edmargin eemeir egplot ellipsis elmath elpres elsarticle em emulateapj endfloat endheads engpron engrec enumitem envbig environ epigraph epiolmec eqlist eqname eqparbox errata esdiff esint esint-type1 etaremune etoolbox eukdate everypage exam examdesign examplep exceltex exercise expdlist export extract facsimile fancynum fancytooltips fax figsize filecontents fink fixfoot fixme flabels flacards flagderiv flashcards flippdf floatrow flowfram fmp fmtcount fnbreak fncychap foilhtml fonttable footmisc footnpag forarray forloop formlett formular frankenstein fribrief fullblck fullpict fundus gauss gcard gcite genmpage geomsty ginpenc gloss gmdoc gmeometric gmiflink gmutils gmverb graphicx-psmin grfpaste grnumalt guitbeamer hanging harpoon hc hhtensor hilowres histogr hitec hpsdiss hvfloat hypdvips hyper hyperref-docsrc hyperxmp hyphenat ifmslide ifplatform image-gallery inlinedef interactiveworkbook inversepath invoice ipa iso iso10303 isodate isonums isodoc isorot isotope kalender kastrup kerntest keystroke labbook labelcas labels lastpage latex-tds layouts lazylist lcd lcg leading leftidx lettre lettrine lewis lhelp limap lipsum listliketab listofsymbols lkproof localloc logpap lsc ltablex ltabptch ltxindex mailing makebarcode makebox makecell makecirc makecmds makedtx makeglos manfnt manuscript mapcodes maple marginnote mathexam maybemath mcaption mceinleger mcite mciteplus memexsupp menu method metre mff mftinc minipage-marginpar minitoc minutes misc209 mla-paper mlist mmap moderncv modroman moresize moreverb movie15 mparhack msc msg mslapa mtgreek multenum multibbl multicap multirow nag namespc ncclatex ncctools newfile newlfm newspaper newthm newvbtm niceframe noitcrul nomencl nomentbl nonfloat notes ntabbing ntheorem numname numprint ocr-latex octavo oldstyle onlyamsmath opcit outline outliner overpic pageno pagenote paper papercdcase papertex paralist paresse patch patchcmd pauldoc pawpict pbox pbsheet pdfcprot pdfscreen pdfslide pdfsync pdfwin pecha perltex permute petiteannonce philex photo pittetd placeins plates plweb polyglot polynom polynomial polytable postcards ppower4 ppr-prv preprint prettyref preview probsoln progkeys program progress prosper protex protocol psfragx pst-pdf qcm qstest qsymbols quotchap quotmark randtext rccol rcsinfo recipecard rectopma refcheck refman refstyle regcount register relenc repeatindex resume rlepsf rmpage robustcommand robustindex romannum rotfloat rotpages rst rtkinenc sagetex sauerj savefnmark savesym savetrees scale scalebar schedule sciwordconv script sdrt sectionbox sectsty semantic semioneside seqsplit sf298 sffms sfmath shadbox shadethm shapepar shipunov shorttoc show2e showdim showexpl showlabels sidecap simplecv simplewick slantsc slashbox smalltableof smartref smflatex snapshot soul sparklines splitindex spotcolor sprite srcltx sseq ssqquote stack statistik stdclsdv stdpage stringstrings sttools stubs subdepth subeqn subeqnarray subfigure subfloat substr supertabular svgcolor svn svn-multi syntax syntrace synttree tableaux tablists tabto-ltx tabulary talk taupin tcldoc technics ted texilikecover texlogos texmate texpower texshade textcase textfit textmerg textpos theoremref thinsp thmtools thumb ticket timesht timing titlefoot titlesec titling tocbibind tocloft tocvsec2 todo tokenizer toolbox topfloat totpages tracking trfsigns trsym trivfloat twoup type1cm typedref typogrid ucs uebungsblatt ulsy umoline underlin undertilde units unroman upmethodology upquote ushort varindex varsfromjobname vector versions vhistory vita vmargin volumes vpe vrsion vwcol wallpaper warning warpcol was williams wordlike wrapfig xargs xbmc xtab xtcapts xdoc xfor xifthen xmpincl xnewcommand xoptarg xstring xytree yafoot yplan zed-csp ziffer zwgetfdate collection-latexextra
"
TEXLIVE_MODULE_DOC_CONTENTS="AkkTeX.doc ESIEEcv.doc GuIT.doc HA-prosper.doc Tabbing.doc a0poster.doc abstract.doc achemso.doc acronym.doc addlines.doc adrconv.doc adrlist.doc akletter.doc altfont.doc amsaddr.doc animate.doc answers.doc anyfontsize.doc appendix.doc arcs.doc arrayjob.doc assignment.doc attachfile.doc authorindex.doc autotab.doc beamer-contrib.doc begriff.doc beton.doc bez123.doc bezos.doc bigfoot.doc binomexp.doc bizcard.doc blindtext.doc blowup.doc boites.doc bookest.doc booklet.doc boxhandler.doc breakurl.doc bullcntr.doc bussproofs.doc calrsfs.doc calxxxx.doc captcont.doc casyl.doc catechis.doc cbcoptic.doc ccaption.doc cclicenses.doc cd.doc cd-cover.doc cdpbundl.doc cellspace.doc changebar.doc changes.doc chappg.doc chapterfolder.doc china2e.doc chletter.doc circ.doc clefval.doc cleveref.doc clock.doc cmdstring.doc codepage.doc colorinfo.doc colorwav.doc combine.doc comment.doc concprog.doc constants.doc contour.doc cooking.doc cool.doc coollist.doc coolstr.doc cooltooltips.doc coordsys.doc courseoutline.doc coursepaper.doc coverpage.doc crossreference.doc crosswrd.doc csquotes.doc csvtools.doc cuisine.doc cursor.doc cv.doc cweb-latex.doc cwpuzzle.doc dashrule.doc datatool.doc dateiliste.doc datenumber.doc datetime.doc delimtxt.doc diagnose.doc dialogl.doc dichokey.doc dinbrief.doc directory.doc dlfltxb.doc dnaseq.doc docmfp.doc doi.doc dotarrow.doc dpfloat.doc dprogress.doc drac.doc draftcopy.doc draftwatermark.doc dtk.doc dtxgallery.doc dvdcoll.doc eCards.doc easy.doc ean13isbn.doc ebezier.doc ecclesiastic.doc ecv.doc ed.doc edmargin.doc eemeir.doc egplot.doc ellipsis.doc elmath.doc elpres.doc elsarticle.doc em.doc emulateapj.doc endfloat.doc endheads.doc engpron.doc engrec.doc enumitem.doc environ.doc epigraph.doc epiolmec.doc eqlist.doc eqparbox.doc errata.doc esdiff.doc esint.doc esint-type1.doc etaremune.doc etoolbox.doc eukdate.doc everypage.doc exam.doc examdesign.doc examplep.doc exceltex.doc exercise.doc expdlist.doc export.doc extract.doc facsimile.doc fancynum.doc fancytooltips.doc fax.doc figsize.doc filecontents.doc fink.doc fixfoot.doc fixme.doc flabels.doc flacards.doc flagderiv.doc flashcards.doc flippdf.doc floatrow.doc flowfram.doc fmp.doc fmtcount.doc fnbreak.doc fncychap.doc fonttable.doc footmisc.doc footnpag.doc forarray.doc forloop.doc formlett.doc formular.doc frankenstein.doc fribrief.doc fullblck.doc fullpict.doc fundus.doc gauss.doc gcard.doc gcite.doc genmpage.doc geomsty.doc ginpenc.doc gloss.doc gmdoc.doc gmeometric.doc gmiflink.doc gmutils.doc gmverb.doc graphicx-psmin.doc grfpaste.doc grnumalt.doc guitbeamer.doc hanging.doc harpoon.doc hc.doc hhtensor.doc histogr.doc hitec.doc hpsdiss.doc hvfloat.doc hypdvips.doc hyperref-docsrc.doc hyperxmp.doc hyphenat.doc ifmslide.doc ifplatform.doc image-gallery.doc inlinedef.doc interactiveworkbook.doc inversepath.doc invoice.doc ipa.doc iso.doc iso10303.doc isodate.doc isodoc.doc isorot.doc kastrup.doc kerntest.doc keystroke.doc labbook.doc labelcas.doc labels.doc lastpage.doc layouts.doc lazylist.doc lcd.doc leading.doc leftidx.doc lettre.doc lettrine.doc lewis.doc lhelp.doc lipsum.doc listliketab.doc listofsymbols.doc lkproof.doc localloc.doc logpap.doc lsc.doc ltabptch.doc ltxindex.doc mailing.doc makebarcode.doc makebox.doc makecell.doc makecirc.doc makecmds.doc makedtx.doc makeglos.doc manuscript.doc maple.doc marginnote.doc mathexam.doc maybemath.doc mcaption.doc mceinleger.doc mcite.doc mciteplus.doc memexsupp.doc method.doc metre.doc mff.doc mftinc.doc minipage-marginpar.doc minitoc.doc minutes.doc mla-paper.doc mlist.doc mmap.doc moderncv.doc modroman.doc moresize.doc moreverb.doc movie15.doc mparhack.doc msc.doc msg.doc mslapa.doc mtgreek.doc multenum.doc multibbl.doc multicap.doc multirow.doc nag.doc namespc.doc ncclatex.doc ncctools.doc newfile.doc newlfm.doc newspaper.doc newvbtm.doc niceframe.doc noitcrul.doc nomencl.doc nomentbl.doc nonfloat.doc notes.doc ntabbing.doc ntheorem.doc numname.doc numprint.doc ocr-latex.doc octavo.doc onlyamsmath.doc opcit.doc outline.doc outliner.doc overpic.doc pagenote.doc paper.doc papercdcase.doc papertex.doc paralist.doc paresse.doc pauldoc.doc pbox.doc pbsheet.doc pdfcprot.doc pdfscreen.doc pdfslide.doc pdfsync.doc pdfwin.doc pecha.doc perltex.doc permute.doc petiteannonce.doc philex.doc photo.doc pittetd.doc placeins.doc plates.doc plweb.doc polyglot.doc polynom.doc polynomial.doc polytable.doc postcards.doc ppower4.doc ppr-prv.doc preprint.doc prettyref.doc preview.doc probsoln.doc progkeys.doc program.doc progress.doc prosper.doc protex.doc protocol.doc psfragx.doc pst-pdf.doc qcm.doc qstest.doc qsymbols.doc quotchap.doc quotmark.doc randtext.doc rccol.doc rcsinfo.doc recipecard.doc rectopma.doc refcheck.doc refman.doc refstyle.doc regcount.doc register.doc relenc.doc repeatindex.doc rlepsf.doc rmpage.doc robustcommand.doc robustindex.doc romannum.doc rotfloat.doc rotpages.doc rst.doc rtkinenc.doc sagetex.doc sauerj.doc savefnmark.doc savetrees.doc scale.doc scalebar.doc schedule.doc sciwordconv.doc script.doc sdrt.doc sectionbox.doc sectsty.doc semantic.doc semioneside.doc seqsplit.doc sf298.doc sffms.doc shadethm.doc shapepar.doc shipunov.doc shorttoc.doc show2e.doc showexpl.doc showlabels.doc sidecap.doc simplecv.doc simplewick.doc slantsc.doc slashbox.doc smalltableof.doc smartref.doc smflatex.doc snapshot.doc soul.doc sparklines.doc splitindex.doc spotcolor.doc sprite.doc srcltx.doc sseq.doc ssqquote.doc statistik.doc stdclsdv.doc stdpage.doc stringstrings.doc sttools.doc stubs.doc subdepth.doc subeqn.doc subeqnarray.doc subfigure.doc subfloat.doc substr.doc supertabular.doc svgcolor.doc svn.doc svn-multi.doc syntax.doc syntrace.doc synttree.doc tableaux.doc tablists.doc tabto-ltx.doc tabulary.doc talk.doc tcldoc.doc technics.doc ted.doc texmate.doc texpower.doc texshade.doc textcase.doc textfit.doc textmerg.doc textpos.doc theoremref.doc thinsp.doc thmtools.doc thumb.doc ticket.doc timesht.doc timing.doc titlesec.doc titling.doc tocbibind.doc tocloft.doc tocvsec2.doc todo.doc tokenizer.doc toolbox.doc topfloat.doc totpages.doc trfsigns.doc trsym.doc trivfloat.doc twoup.doc type1cm.doc typedref.doc typogrid.doc ucs.doc uebungsblatt.doc ulsy.doc umoline.doc underlin.doc undertilde.doc units.doc unroman.doc upmethodology.doc ushort.doc varindex.doc varsfromjobname.doc vector.doc vhistory.doc vita.doc vmargin.doc volumes.doc vpe.doc vrsion.doc vwcol.doc wallpaper.doc warpcol.doc was.doc wordlike.doc wrapfig.doc xargs.doc xtab.doc xtcapts.doc xdoc.doc xfor.doc xifthen.doc xmpincl.doc xnewcommand.doc xoptarg.doc xstring.doc xytree.doc yafoot.doc yplan.doc zed-csp.doc ziffer.doc zwgetfdate.doc "
TEXLIVE_MODULE_SRC_CONTENTS="ESIEEcv.source GuIT.source HA-prosper.source Tabbing.source abstract.source achemso.source acronym.source addlines.source adrconv.source adrlist.source altfont.source amsaddr.source answers.source appendix.source arcs.source attachfile.source beton.source bez123.source bigfoot.source binomexp.source bizcard.source blindtext.source blowup.source boites.source booklet.source bophook.source boxhandler.source breakurl.source bullcntr.source captcont.source catechis.source ccaption.source cclicenses.source cd.source cd-cover.source cdpbundl.source changebar.source changes.source chappg.source chapterfolder.source chletter.source circ.source cjw.source clefval.source cleveref.source cmdtrack.source cmsd.source codepage.source colorwav.source combine.source comment.source constants.source contour.source cooking.source cool.source coollist.source coolstr.source cooltooltips.source coordsys.source coverpage.source crossreference.source crosswrd.source csvtools.source cuisine.source cweb-latex.source cwpuzzle.source dashbox.source dashrule.source datatool.source dateiliste.source datenumber.source datetime.source decimal.source delimtxt.source diagnose.source dialogl.source dinbrief.source dnaseq.source docmfp.source dotarrow.source dotseqn.source dprogress.source drac.source draftcopy.source draftwatermark.source dtk.source dtxgallery.source eCards.source ebezier.source ecclesiastic.source ecv.source ed.source edmargin.source eemeir.source egplot.source ellipsis.source elmath.source elsarticle.source em.source endfloat.source endheads.source engpron.source engrec.source environ.source epigraph.source epiolmec.source eqlist.source eqparbox.source errata.source esdiff.source esint.source etaremune.source eukdate.source everypage.source examdesign.source exercise.source expdlist.source export.source extract.source facsimile.source fancynum.source fancytooltips.source figsize.source filecontents.source fink.source fixme.source flabels.source flagderiv.source flashcards.source flippdf.source floatrow.source flowfram.source fmp.source fmtcount.source fnbreak.source foilhtml.source fonttable.source footmisc.source footnpag.source forarray.source forloop.source formular.source frankenstein.source fullblck.source fundus.source gcite.source genmpage.source geomsty.source ginpenc.source graphicx-psmin.source grnumalt.source hanging.source hc.source hhtensor.source hilowres.source histogr.source hpsdiss.source hyper.source hyperxmp.source hyphenat.source ifmslide.source ifplatform.source inlinedef.source inversepath.source iso.source iso10303.source isodate.source isodoc.source isorot.source isotope.source kastrup.source kerntest.source labbook.source labelcas.source labels.source lastpage.source latex-tds.source layouts.source lcd.source lcg.source leading.source leftidx.source lettrine.source lhelp.source limap.source lipsum.source listliketab.source localloc.source logpap.source ltxindex.source mailing.source makebox.source makecell.source makecmds.source makedtx.source manfnt.source manuscript.source mapcodes.source marginnote.source mathexam.source mcaption.source mcite.source menu.source method.source metre.source mff.source mftinc.source minipage-marginpar.source minitoc.source minutes.source mlist.source modroman.source moresize.source moreverb.source mparhack.source msg.source mtgreek.source multibbl.source multicap.source nag.source namespc.source ncctools.source newfile.source newlfm.source newspaper.source newvbtm.source niceframe.source noitcrul.source nomencl.source nomentbl.source nonfloat.source notes.source ntheorem.source numprint.source octavo.source oldstyle.source onlyamsmath.source opcit.source pageno.source pagenote.source paper.source papercdcase.source papertex.source paralist.source paresse.source patch.source patchcmd.source pauldoc.source pawpict.source pbox.source pbsheet.source pdfcprot.source perltex.source permute.source photo.source pittetd.source plweb.source polyglot.source polynom.source polynomial.source polytable.source ppr-prv.source preprint.source prettyref.source preview.source probsoln.source progkeys.source prosper.source protocol.source psfragx.source pst-pdf.source qcm.source qstest.source qsymbols.source quotchap.source quotmark.source rccol.source rcsinfo.source recipecard.source refman.source refstyle.source regcount.source register.source relenc.source rmpage.source robustcommand.source romannum.source rotfloat.source rst.source rtkinenc.source sagetex.source sauerj.source savefnmark.source savetrees.source scale.source scalebar.source schedule.source sciwordconv.source sectsty.source semantic.source semioneside.source seqsplit.source sf298.source sffms.source shorttoc.source show2e.source showexpl.source showlabels.source sidecap.source simplecv.source simplewick.source slantsc.source snapshot.source soul.source splitindex.source srcltx.source sseq.source ssqquote.source stack.source statistik.source stdclsdv.source stdpage.source stringstrings.source subdepth.source subeqn.source subeqnarray.source subfigure.source subfloat.source supertabular.source svn.source svn-multi.source syntrace.source synttree.source tablists.source tabulary.source talk.source tcldoc.source technics.source ted.source texmate.source texpower.source texshade.source textcase.source textfit.source textmerg.source textpos.source thmtools.source thumb.source timesht.source titling.source tocbibind.source tocloft.source tocvsec2.source todo.source toolbox.source totpages.source trfsigns.source trsym.source trivfloat.source twoup.source type1cm.source typedref.source typogrid.source ulsy.source umoline.source underlin.source undertilde.source units.source unroman.source upmethodology.source ushort.source varindex.source vector.source vmargin.source volumes.source vrsion.source vwcol.source warning.source warpcol.source was.source wordlike.source xargs.source xtab.source xtcapts.source xdoc.source xfor.source xmpincl.source yafoot.source "
inherit texlive-module
DESCRIPTION="TeXLive LaTeX supplementary packages"

LICENSE="GPL-2 as-is BSD freedist GPL-1 GPL-2 LGPL-2 LPPL-1.2 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2008
>=dev-texlive/texlive-fontsrecommended-2008
!dev-tex/achemso
!dev-tex/prosper
!dev-tex/ha-prosper
!dev-tex/texpower
!dev-tex/cdcover
!dev-tex/ppower4
!=dev-texlive/texlive-latexrecommended-2007*
!=dev-texlive/texlive-latex3-2007*
!=dev-texlive/texlive-humanities-2007*
"
RDEPEND="${DEPEND} "
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/perltex/perltex.pl texmf-dist/scripts/ppower4/pdfthumb.texlua texmf-dist/scripts/ppower4/ppower4.texlua texmf-dist/scripts/pst-pdf/ps4pdf texmf-dist/scripts/vpe/vpe.pl"
