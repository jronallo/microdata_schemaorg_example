HTML5 Microdata and Schema.org
==============================

by Jason Ronallo, Digital Collections Technology Librarian, NCSU Libraries

DRAFT NOTE: YKK means things that still need zipped up.

On June 2, 2011 [Bing](http://www.bing.com/community/site_blogs/b/search/archive/2011/06/02/bing-google-and-yahoo-unite-to-build-the-web-of-objects.aspx), 
[Google](http://googleblog.blogspot.com/2011/06/introducing-schemaorg-search-engines.html ), 
and 
[Yahoo](http://developer.yahoo.com/blogs/ydn/posts/2011/06/introducing-schema-org-a-collaboration-on-structured-data/ ) 
announced the joint effort [Schema.org](http://schema.org). When the big search
engines talk, web site authors listen. 

This is an introduction to Microdata and Schema.org. 
YKK
The tutorial will introduce you to implementing these new technologies on a 
site for discovery of cultural heritage materials.
Along the way, you will be introduced to some tools for implementers and some
issues with applying this to cultural heritage materials. 
The conclusion will
provide some suggestions on how the cultural heritage sector could work to 
better leverage Microdata and Schema.org.

Foundation
----------

### HTML5

The [HTML5 standard](http://www.w3.org/TR/html5/) 
(or [HTML Living Standard](http://www.whatwg.org/specs/web-apps/current-work/multipage/), 
depending on who you ask) has brought a lot of changes to web authoring.
Amongst all the buzz about HTML5 (some of which is not even part of the HTML spec),
HTML5 Microdata, a new semantic markup syntax that *is* part of the HTML standard,
often went overlooked. HTML elements often have
some semantics. For example, an `ol` element is an ordered list, and by default
gets rendered with numbers for the list items. 
With HTML5 we also have new semantic elements 
like `header`, `nav`, `article`, and `footer` that allow more expressiveness for 
page authors. A bunch of `div`s with various class names 
is no longer the way to divide up so much content. These new elements also
enable new tools and better services. Browser plugins can pull out the article for a 
cleaner reading 
experience, or search engines to give more weight to the `article` content 
rather than the advertising sidebar.

While these new elements provide useful extra information about the content, 
they provide no deeper understanding of what the `article` is *about*. 
In many cases you are probably
using a nicely normalized relational database or an XML document with a lot of 
fielded information about your resources. Putting that information in HTML 
loses a lot of what you
already know. The trip metadata takes from the database or XML into HTML results 
in lost meaning. Maybe a human can read your field labels to understand your 
metadata, but that meaning is lost on machines.

### One Simple Solution

One solution to communicate more of this metadata is to provide an alternative 
representation of your data separate from the HTML representation. You could
even help with auto-detection of that content by providing an alternative link
in the `head` of your HTML document. 

Here's a simple [example](http://inkdroid.org/journal/2011/09/22/stepping-backwards/) 
of making RIS formatted citation data available:

    <link rel="alternate" type="application/x-research-info-systems" href="/search?q=cartoons&format=ris" />
 
The link provides the type of the alternative representation and a relative URL 
where it can be found.

This approach can work in many cases, but it has some problems.
Techniques like this do not use the visible content
of the HTML, so the consumers of your data have to know to look for this
particular invisible content. It also adds a layer of complication by relying 
on digital collections to have APIs or
metadata gateways that can be burdensome to setup and expensive for organizations
to maintain.

### Embedding Data in Markup

The HTML representation is most visible to users, so it
is also the HTML code which gets the most attention from developers. 
Little-used, overlooked APIs or data feeds are easy to let go stale.
If the website goes down, you are likely to hear about it from multiple sources
immediately. If the OAI-PMH gateway goes down, it would probably take longer
for you to find out about it. Hidden services and content are too easy to get
neglected. Data embedded in visible HTML helps keep the representations in sync
so that page authors only have to expose one public version of their data.
This insight has lead to a number of different standards over time
which take the
approach of embedding structured data with the visible HTML content. Microdata
is just one of the syntaxes in use today.

### History of Structured Data in HTML

Other efforts that came before Microdata have solved this same problem of marking
up the meaning of content. Of the main syntaxes used today,
[Microformats](http://microformats.org/) was not the first but was
an [early effort](http://lists.w3.org/Archives/Public/public-html-data-tf/2011Dec/0030.html)
to provide "a general approach
of using visible HTML markup to publish structured data to the web." 
Some Microformat
specifications like [hCard](http://microformats.org/wiki/hcard), 
[hCalendar](http://microformats.org/wiki/hcalendar), and 
[rel-license](http://microformats.org/wiki/rel-license) are in common use across
the web. Development of the various small Microformat standards take place on 
a community wiki.
Simply put, Microformats usually use the convention of standard class 
names to provide meaning on a web page. The latest version [microformats-2](http://microformats.org/wiki/microformats-2)
simplifies and harmonizes these conventions across specifications significantly.

RDFa, a standard of the W3C, has the vision of 
"[Bridging the Human and Data Webs](http://www.w3.org/TR/xhtml-rdfa-primer/)."
The idea is to provide attributes and processing rules for embedding RDF (and
all of its graph-based, linked data goodness) in HTML. 
With all that expressive power comes some difficulty, and
implementing RDFa has been overly complex for most web developers. Google has
supported RDFa in some fashion since 2009, and over that time had discovered
a [large error rate](http://lists.w3.org/Archives/Public/public-vocabs/2011Oct/0113.html)
in the application of RDFa by webmasters. 
Simplicity is one of the main reasons for the development of Microdata and the 
search engines preferring it over RDFa.
In part in
reaction to greater adoption of Microdata, a simplified profile of RDFa has been 
created. [RDFa Lite 1.1](http://www.w3.org/2010/02/rdfa/sources/rdfa-lite/Overview-src.html)
provides simpler authoring guidelines that 
[mirror more closely the syntax of Microdata](http://lists.w3.org/Archives/Public/public-html-data-tf/2011Nov/0070.html).

It also bears mentioning that in the library space, we have developed 
specifications which tried to solve similar problems of making structured data 
available to machines through HTML pages.
The [unAPI](http://unapi.info/) specification uses a microformat for 
exposing (through the [deprecated `abbr` method](http://microformats.org/wiki/value-class-pattern)) 
the presence of identifiers
which may resolve to alternative formats through a service. 
[COinS](http://ocoins.info/) uses empty spans to make OpenURL context objects
available for autodiscovery by machines.

### So what is Microdata?

Microdata came out of a [long thread about incorporating RDFa in HTML5](http://www.jenitennison.com/blog/node/124).
Because RDFa simply was not going to be incorporated into HTML5, 
something else was needed to fill the gap.
Out of that thread and collected use cases [Ian "Hixie" Hickson](http://hixie.ch/),
the editor of the HTML5 specification,
showed the first work on Microdata on [May 10, 2009](http://lists.whatwg.org/htdig.cgi/whatwg-whatwg.org/2009-May/019681.html)
(the syntax has changed some since then). The syntax is designed to be simple
for page authors to implement.

In technical Microdata terms, the things on an HTML page being described are 
items. Each item is made up of one or more key-value pairs, a property and a
value.
The Microdata syntax is completely made up of attributes. These attributes 
can be used on any valid HTML element. Only three new HTML
attributes are core to the data model:

* `itemscope` says that there is a new item
* `itemtype` specifies the type of item
* `itemprop` gives the item properties and values

### A First Example

    <div itemscope itemtype="unorganization">
      <span itemprop="eponym">code4lib</span>
    </div>
    
The user of a browser would only see the text "code4lib".
The snippet provides more meaning for machines by asserting that there is an 
"unorganization" with the "eponym" of "code4lib."

The `@itemscope` attribute creates an item and requires no value.
The `@itemtype` attribute asserts that the type of thing being described is an 
"unorganization."
This item has a single
key-value pair--the property "eponym" with a value of "code4lib." 

To make it clear to someone who thinks in JSON, here is what the item looks
like:

    {
      "type": [
        "unorganization"
      ],
      "properties": {
        "eponym": [
          "code4lib"
        ]
      }
    }

Those are the only three attributes necessary for a complete understanding of the 
Microdata model. (You'll learn about two more optional ones later.) 
Pretty simple, right?

### What is Schema.org?

While the above snippet is completely valid Microdata, 
it uses arbitrary language for its `@itemtype` and `@itemprop` values. If you
only need to communicate this information within a tight community and do not
need anyone else to ever understand what your data means, 
that may be just fine. But for the most
part you probably want many other machines to understand the meaning of
your content. To accomplish this you need to use a shared language so that page 
authors and consumers can cooperate on how to interpret the meaning.

This is where the Schema.org vocabulary comes in. The search 
engines (Bing, Google, Yahoo) created Schema.org 
and have agreed to support and understand it. It is unrealistic for them to try
to support every vocabulary in use, so this is an attempt to have a shared
vocabulary at broad, web scale focusing on popular concepts.
It stakes a position as a ["middle" ontology](http://lists.w3.org/Archives/Public/public-vocabs/2011Nov/0006.html)
that does not attempt to have the scope of an "ontology of everything" or go 
into depth in any one area.
A central goal of having such a broad schema all in one place is to 
[simplify things for mass adoption](http://blog.schema.org/2011/11/using-rdfa-11-lite-with-schemaorg.html?showComment=1321045329383#c3006481536068088400)
and cover the most common use cases.
The vocabulary does seem to have a bias towards commercial use cases.
You can browse the 
[full hierarchy of the vocabulary](http://schema.org/docs/full.html) to get a 
feel of the bounds of the world according to search engines. 

Schema.org defines a hierarchy of types all descending from Thing. Thing has four
properties (description, image, name, url) which are inherited by all other types.
Child types can add their own properites and in turn can have their own children 
types. Each property name has the same meaning when found in any type in the 
vocabulary. We will get to other specifics as we go through a tutorial.

Microdata and Schema.org have a tight connection, though each can be used without
the other. 
The search engines are currently the main consumers
of Schema.org data and have a stated preference for Microdata.
The Schema.org examples are written using the Microdata syntax.

Here is the above Microdata example rewritten 
use the Schema.org [`Organization`](http://schema.org/Organization)
type (and make more sense).

    <div itemscope itemtype="http://schema.org/Organization">
      <span itemprop="name">code4lib</span>
    </div>

### Rich Snippets

The most obvious way that the search engines are currently using
Microdata is to use the embedded data on pages to display rich snippets in 
search results. 
If you have done a Google search in the past two years, you have probably seen 
some examples of rich snippets showing up in your search results.
You can see
good examples of how powerful this is by doing a [Google Recipe Search](http://www.google.com/landing/recipes/)
for "vegan cupcakes":

<p>
<img alt="Rich Snippet for Vegan Cupcakes" src="/images/vegan_cupcakes.png"/>
</p>

This search result snippet for a recipe includes an image, reviews, cooking 
time, calorie count, some of the text introducing the recipe, and a list of
some of the ingredients needed. This gives a lot more scent to the user for 
clicking on a particular result.
Snippets with this kind of extra information are
reported to [increase click through rates](http://www.heppresearch.com/gr4google). 

Google started presenting rich snippets [in 2009](http://googlewebmastercentral.blogspot.com/2009/05/introducing-rich-snippets.html). 
Using embedded markup like microformats, RDFa or Microdata, page authors 
can influence what could show up in a search result snippet.
Both [Microformats](http://support.google.com/webmasters/bin/answer.py?hl=en&answer=146897) 
and [RDFa](http://support.google.com/webmasters/bin/answer.py?hl=en&answer=146898) 
were promoted
for rich snippets in the past and continue to be supported. 
Google [added support for Microdata for Rich Snippets](http://googlewebmastercentral.blogspot.com/2010/03/microdata-support-for-rich-snippets.html) 
in early 2010. After RDFa Lite was created, the Schema.org partners agreed to
support that syntax as well.

Before Schema.org, rich snippets were constrained to being triggered by 
the few types defined by [data-vocabulary.org](http://www.data-vocabulary.org/), 
which prefigured the Schema.org approach. 
Reviews, products, and breadcrumbs were the kinds of common types of data that
could be embedded.
At the time of this writing there is still not support for all, or even most,
of the Schema.org types. The number of supported types and example rich 
snippets has been slowly growing. The promise is that many more of the Schema.org
types will begin to trigger rich snippets.

The main reason to be using Microdata with Schema.org is that it is
the latest search-engine preferred method for exposing structured data in HTML.
While other consumers for structured data using Microdata and/or Schema.org may
appear in the future, the most compelling uses cases
are currently from the search engines, especially for rich snippets. 
By providing the search engines
with more data on your pages, it improves the search experience of users and 
can draw them to your site. Since most of the users of your site likely come
through the search engines, this could be a powerful way to draw more users
to your resources.

From a developer's perspective there are [many considerations](https://dvcs.w3.org/hg/htmldata/raw-file/default/html-data-guide/index.html) 
for choosing a particular syntax. Microdata has a natural fit with HTML and is
designed for simplicity and ease of implementation. Schema.org simplifies the
documentation and choices to make.
In my own experience 
implementing Microdata and Schema.org was orders of magnitude simpler than
a past failed attempt at implementing RDFa using various vocabularies on a similar
site.

Tutorial
--------

This tutorial will lead you through implementing Microdata and Schema.org on
a pre-existing site for exposing digitized collections. The example is based on
[NCSU Libraries' Digital Collections: Rare and Unique Materials](http://d.lib.ncsu.edu/collections).
Each section will lead you through decisions that are made and common
problems that are encounted in implementing Microdata and Schema.org. 

YKK 

* some useful tools. 
* tips tricks
* deeper dive into the specifications

### Before Microdata

Here's a screenshot of the page to mark up. As we add Microdata to the page,
the appearance of the page will not change at all. The page uses a grid system to
place the image on the left and the metadata to the right.

These students are jumping from excitement to learn more about HTML5 Microdata 
and Schema.org!

<p>
<img alt="Screenshot of page for digital photograph" src="/images/bell_tower_screenshot.png"/>
</p>

Here is the basic structure of the main content of the page with 
some sections and attributes removed with ellipses for brevity.

    <div id="main" class="container_12">
      <h2 id="page_name">
        Students jumping in front of Memorial Bell Tower
      </h2>
      <div class="grid_5"> 
          <img id="main_image" alt="Students jumping in front of Memorial Bell Tower" src="/images/bell_tower.png">    
      </div> 
      <div id="metadata" class="grid_7">
        <div id="item" class="info">
          <h2>Photograph Information</h2>
          <dl>   
            ...         
          </dl> 
        </div><!-- item -->
        
        <div id="building" class="info">
          <h2>Building Information</h2>
          <dl>
            ...        
          </dl>      
        </div><!-- building -->
        
        <div id="source" class="info">
          <h2>Source Information</h2>
          <dl>
            ...
          </dl>     
        </div><!-- source -->
      </div>
    </div>


### Adding a WebPage

When using the schema.org vocabularies, every page is implicitly assumed to be 
some kind of [WebPage](http://schema.org/WebPage), but the advice is to 
explicitly declare the type of page. When picking an appropriate type, it is 
best to choose the most specific type that could accurately represent the
thing we want to mark up. In this case it seems appropriate to use 
[ItemPage](http://schema.org/ItemPage) which is a subclass of WebPage. ItemPage
adds no new properties to WebPage, but it communicates to the search engines that
the page refers to a single item rather than a search results or other
type of page.
I can find no proof for this yet, but it may be that using ItemPage will give
an extra hint to a crawler that a page should be indexed or treated differently
from other types of web pages. 
For the same reason, marking up a SearchResultsPage could give the hint to the
search engines to crawl but not index the page.

When you are adding Microdata there is a sense in which you are always just 
describing a web page. Ian Hickson the editor of the Microdata specification, 
has said that
Microdata items exist "in the context of a page and its 
DOM. It does not have an independent existence outside the page." 
([Ian Hickson on public-vocabs list](http://lists.w3.org/Archives/Public/public-html-data-tf/2011Oct/0140.html).)
This is different than the way RDFa may think about embedded structured data in 
HTML as part of a graph which links items together across the web. Microdata 
is not so much linked data as it is a description of a single page. 
While there are efforts to serialize Microdata as RDF, the Microdata model
is tree-based so it has some limitations as linked data.

Below the ItemPage is added to the `div#main` on the page and some properties
are added within the scope of that `div#main`. 

    <div id="main" class="container_12" itemscope itemtype="http:schema.org/ItemPage">
      <h2 id="page_name" itemprop="name">
        Students jumping in front of Memorial Bell Tower
      </h2>
      <div class="grid_5">
          <img id="main_image" alt="Students jumping in front of Memorial Bell Tower" 
            src="/images/bell_tower.png" itemprop="image">    
      </div>
      <div id="metadata" class="grid_7">
        ...
      </div>
    </div>

Here we apply the `itemscope` and `itemtype` attributes at a level in the DOM
that surrounds everything we want to describe about the page.
Since we are describing, the page, we could instead add the `itemscope` and
`itemtype` at a higher level. If we need to use some metadata in the `head` of
the document, say the `title` element, we could apply this to the `body` or
even the `html`
element, though there are [some limitations to using Microdata within `head`](https://www.w3.org/Bugs/Public/show_bug.cgi?id=15304). 

Within `div#main` we add the two `itemprop`s for the "name" and "image"
properties. Different elements take their `itemprop` value from different
places. 
In this case the "name" property is taken from the text content of `h2` element.
For the `img` element the value is taken from the `src` attribute, which is
then resolved into an absolute URL. The `a` element uses the absolute URL
from the `href` attribute. Like `img` and `a` many elements provide their 
values through an attribute rather than the text content.
If you start using Microdata, you will want to consult 
[this list from the spec](http://www.whatwg.org/specs/web-apps/current-work/multipage/microdata.html#values)
which details how property values are determind for different elements.


### Microdata JSON and DOM API

One of the cool features of Microdata is that it is designed to be 
[extracted into JSON](http://www.whatwg.org/specs/web-apps/current-work/multipage/microdata.html#json). 
You can copy any of the HTML snippets with an itemscope from here into 
[Live Microdata](http://foolip.org/microdatajs/live/) 
to see what the JSON output would look like. 

Live Microdata uses [MicrodataJS](https://gitorious.org/microdatajs/),
which is a Javascript (jQuery) implementation of the [Microdata DOM API](http://www.whatwg.org/specs/web-apps/current-work/multipage/microdata.html#microdata-dom-api).
The Microdata DOM API is another neat feature of HTML5 Microdata
which allows you to extract Microdata client-side. 

You can test whether your browser implements the Microdata DOM API by running the
[microdata test suite](http://w3c-test.org/html/tests/submission/Opera/microdata/001.html) 
created by Opera. If
you open a page with Microdata with [Opera Next](http://www.opera.com/browser/next/) 
(at the time of this writing version 12.00 alpha, build 1191)
and open up the console (Ctrl+Shift+i), you can play with the Microdata
DOM API a bit. 
`document.getItems()` will return a NodeList of all items. 
The NodeList will contain only the top-level items, in this case one
element. It is possible to get all items of a particular type by specifying the
type or types as an argument like `document.getItems('http://schema.org/ItemPage')`.
This API may change in the future 
["to match what actually gets implemented"](http://old.nabble.com/Re%3A-New-feature-announcement---Implement-HTML5-Microdata-in-WebKit-p32521849.html).

    >>> var itemPage = document.getItems('http://schema.org/ItemPage')
      undefined
    >>> itemPage
      NodeList [<html itemscope="" itemtype="http://schema.org/ItemPage" lang="en">]
    >>> itemPage[0].properties
      HTMLPropertiesCollection [<h2 id="page_name" itemprop="name">, 
        <img itemprop="image" id="main_image" alt="Students jumping in front of Memorial Bell Tower" src="/images/bell_tower.png"/>]


### ItemPage about a Photograph

Now that we have some basic microdata on the page, let's try to to describe more
items on the page. Looking at the valid properties for an [ItemPage](http://schema.org/ItemPage),
it has an `about` property, inherited from [CreativeWork](http://schema.org/CreativeWork).
ItemPage inherits different
properites from Thing, CreativeWork, and WebPage.
In some cases child types add in new properites, but in the case of ItemPage no 
new properties are defined.

If we add `itemprop="about"` to the `div` containing all metadata, then what
would be extracted from the page is just the text content with line breaks and
all. Microdata processing never maintains markup.
(If you need to maintain some snippet of markup,
then [consider](https://dvcs.w3.org/hg/htmldata/raw-file/default/html-data-guide/index.html#syntax-considerations) 
using microformats or RDfa, which have the ability to maintain
XML literals.) 

Microdata is specified in a way where if the
author of the page gets it wrong, the processor may still be able to do something
useful with even just that text content. Processors should expect bad data 
([Conformance](http://schema.org/docs/datamodel.html)).
Looking at how the `about` property is defined, though, the proper value of 
the `about` property is another `Thing` (not a jumble of text). 
In this way Schema.org suggests how to nest items within other items forming
a tree.
In this case specifying Thing as a valid value of the `about` property means 
that any type in the Schema.org hierarchy can be selected to create
a new item as the value of the `about` property. The [Photograph](http://schema.org/Photograph)
type is most appropriate for this example.

Nesting is implemented by using all three attributes 
(`itemprop`, `itemscope`, `itemtype`) on the same element. Doing this states
that the value of a property is a new item of a particular type.
Since all of the metadata is describing the photograph, these attributes
will be applied to `div#metadata` which contains all of the metadata.

At this point the subjects and genres can be added as properties of the
Photograph. Subjects
map well enough to the "keywords" property of `Photograph`. 
These keywords are 
visible to users, so the values are less likely to be used to try to game
search engines to rank for particular terms that had nothing to do with the
content in the body in the way
the use of invisible `meta` keywords in the `head` of a document were long ago.
Google advises page authors to not mark up [non-visible content](http://support.google.com/webmasters/bin/answer.py?hl=en&answer=176035)
on the page, but to stick to adding microdata attributes to what is visible to 
users.

We could attach the "genres" `itemprop` to the `dd` element, but then a processor
would extract all the text contained within as a single chunk of text. 
The genres have some spaces within each term, so rather
than leaving it up to a post-processor to handle that, we apply the same 
`itemprop` to each term separately. This insures that the multiword genres 
remain intact. 
At this time irregardless of the use of 
[singulars or plurals for property names](http://www.w3.org/2011/webschema/track/issues/5)
in the Schema.org documentation, it is allowable in 
to repeat all Schema.org properties like this. When these repeated properties
are parsed, the values are merged under a single property to form a list/array
of values.

The "keywords" `itemprop` cannot be applied to the `a` element that 
surrounds each term.
The gotcha here is that the property value of an `a` element
is the value of its `href` attribute. To work
around this we use the common pattern of adding some extra spans around the
text so that the text content is selected instead.

### Picking Types and Properties (and More Nesting)

After nesting a Photograph within an ItemPage, the nesting can continue further.
The photograph has the Memorial Bell Tower at North Carolina State University in 
the background.
The Photograph is `about` the Memorial Bell
Tower. In this case, 
`LandmarksOrHistoricalBuildings` seems to work well enough as a type. 

    <div id="building" class="info" itemprop="about" itemscope itemtype="http://schema.org/LandmarksOrHistoricalBuildings">

Once we add an item for the building, it is easy to add
name and description properties for the building.
We also have the data to add the address (as a [PostalAddress](http://schema.org/PostalAddress)) 
and geographic location ("geo" property with a value of a [GeoCoordinates](http://schema.org/GeoCoordinates))
as further nested data items.

Picking appropriate types is an important issue for describing the historic record.
At NCSU Libraries we are describing lots of buildings and making related
drawings accessible. Some of these buildings are on the National
Register of Historic Places, but many are buildings of 
lesser note. Some were never built or have since been demolished. 
It could be that for most of the
records of buildings an architectural collection, that a more generic item type
like [Place](http://schema.org/Place)
would be a more appropriate fit. For other buildings there are definitely 
more specific types like Airport, CityHall, Courthouse, Hospital, and Church.

Using a more specific type, it would still be impossible for the search
engines to realize that the items refer to the historic record of these
places rather than to their current services. 
We could be giving exact geographic coordinates for a hospital which was
demolished or no longer in operation!
Also, this is a new metadata facet that may not already being captured in a way
that would be easy to convert to Schema.org types. 
Some retrospective and ongoing work would be needed to 
choose the correct type for
every building. For now NCSU has made the decision to always pick the more
specific type of `LandmarksOrHistoricalBuildings` for all the buildings we
describe as something of a compromise. It better communicates that the resource 
is part of the historic record, but it does lose on the specificity we might
like to have.

Picking appropriate types is one area where Schema.org does not provide anything 
near the level of granularity at which archives and museums often specify the types
of objects they describe. There are types for Painting, Photograph, and 
Sculpture. Some types of objects like drawings, vases, and suits of armor
may have to move back up the hierarchy to use the generic CreativeWork type. 
With the thousands of types of objects that may be held by libraries, archives, 
museums and historical societies (LAMs), it is [not feasible](www.heppnetz.de/files/IEEE-IC-PossibleOntologies-published.pdf) 
to add every type to Schema.org.
One suggestion made by Charles Moad, Director of the Indianapolis Museum of Art 
Lab, is to extend CreativeWork with an objectType property (private correspondence). 

If this "objectType" property were part of Schema.org, then the LAM community 
could suggest that the value of the property come from a vocabulary that 
covers the kinds of objects LAMs collect. 
This could go a long way towards expanding the 
options for LAMs to describe their materials. The [JobPosting](http://schema.org/JobPosting)
type includes an
"occupationalCategory" property which suggests the use of the [BLS O*NET-SOC taxonomy](http://www.onetcenter.org/taxonomy.html)
(though the exact format this value should take is underspecified). This same
pattern of using external vocabularies maintained by domain experts is likely
to be repeated for other property values. 

This still leaves open the question of what free, open vocabulary would allow
for the kind of extensibility LAMs need to cover all of their object types at
a good enough level of specificity. It is not feasible to create a vocabulary
to cover and keep up with every type of thing LAMs may collect.
The [product ontology](http://www.productontology.org/) provides a possible
model for how to create such an extensible vocabulary
by reusing the names of Wikipedia articles 
to identify types of objects. Something like the following code could be done to 
simply reuse the name of the [Plate_armour](http://en.wikipedia.org/wiki/Plate_armour)
article to note that the type of object in the collection is plate armour.
The URL `http://objectontology.org/id/Plate_armour` could resolve to useful 
information and tutorial information similar to the product ontology page for
[Plate armour](http://www.productontology.org/doc/Plate_armour). 
An object in a LAM collection differs enough from a product for sale
to need a new namespace to explain the difference, especially to machines.
This kind of link also begins to make Microdata more linkable data. 

    <div itemscope itemtype="http://schema.org/CreativeWork" itemid="http://www.philamuseum.org/collections/permanent/71286.html">
      <span itemprop="name">Gorget (neck defense) and Cuirass (torso defense), for use in the field</span><br/>
      Item Type: <link itemprop="objectType" href="http://objectontology.org/id/Plate_armour"> Plate armour
    </div>


### Result so far

Here's what our marked up snippet looks like so far: 

    <div id="main" role="main" class="container_12" itemscope itemtype="http:schema.org/ItemPage">
    <h2 id="page_name" itemprop="name">
      Students jumping in front of Memorial Bell Tower
    </h2>
      <div class="grid_5"> 
          <img itemprop="image" id="main_image" alt="Students jumping in front of Memorial Bell Tower" src="/images/bell_tower.png">    
      </div> 
      <div id="metadata" class="grid_7" itemprop="about" itemscope itemtype="http://schema.org/Photograph">
        <div id="item" class="info">
          <h2>Photograph Information</h2>
          <dl>            
            <dt>Created Date</dt>
            <dd>
              circa 1981
            </dd>  
            
            <dt>Subjects</dt>
            <dd>
              <a href="#buildings"><span itemprop="keywords">Buildings</span></a><br>
              <a href="#students"><span itemprop="keywords">Students</span></a><br>
            </dd> 
            
            <dt>Genre</dt>
            <dd>
              <a href="#architectural_photos"><span itemprop="genre">Architectural photographs</span></a><br>
              <a href="#publicity_photos"><span itemprop="genre">Publicity photographs</span></a>         
            </dd>
            
            <dt>Digital Collection</dt>
            <dd><a href="#uapc">University Archives Photographs</a></dd> 
          </dl> 
        </div><!-- item -->
        
        <div id="building" class="info" itemprop="about" itemscope itemtype="http://schema.org/LandmarksOrHistoricalBuildings" itemref="main_image">
          <h2>Building Information</h2>
          <dl>
            <dt>Building Name</dt>
            <dd><a href="#memorial_tower"><span itemprop="name">Memorial Tower</span></a></dd>   
            
            <dt>Description</dt>
            <dd itemprop="description">Memorial Tower honors those alumni who were killed in World War I. 
              The cornerstone was laid in 1922 and the Tower was dedicated on 
              November 11, 1949.</dd>
            
            <dt>Address</dt>
            <dd itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">              
                <span itemprop="streetAddress">2701 Sullivan Drive</span><br>
                <span itemprop="addressLocality">Raleigh</span>, <span itemprop="addressLocality">NC</span> <span itemprop="postalCode">26707</span>              
            </dd>
            
            <dt>Latitude, Longitude</dt>            
            <dd itemprop="geo" itemscope itemtype="http://schema.org/GeoCoordinates"><span itemprop="latitude">35.786098</span>, <span itemprop="longitude">-78.663498</span></dd>
                        
          </dl>      
        </div><!-- building -->
        
        <div id="source" class="info">
          <h2>Source Information</h2>          
          ...     
        </div><!-- source -->
      </div> 
    </div>

All told there are five Microdata items (ItemPage, Photograph, 
LandmarksOrHistoricalBuildings, PostalAddress, GeoCoordinates) on the page.
In part, this snippet now basically says something like this in English:

> This page is an ItemPage about a Photograph. The Photograph is about a 
> LandmarksOrHistoricalBuildings. The Itempage has a "name" of 
> "Students jumping in front of Memorial Bell Tower" and an 
> "image" at "http://example.com//images/bell_tower.png." 
> The Photograph has some "keywords" and "genre."
> The LandmarksOrHistoricalBuildings has a "name" of "Memorial Tower" and a
> "description." The LandmarksOrHistoricalBuildings has an "address" which
> is a PostalAddress item (with its own properties), as well as, a "geo"
> property which is a GeoCoordinates item. 

The nested types could be represented by this image:

YKK create image of nested types

You can see the extracted JSON [at Live Microdata](http://foolip.org/microdatajs/live/?html=%3Cdiv%20id%3D%22main%22%20role%3D%22main%22%20class%3D%22container_12%22%20itemscope%20itemtype%3D%22http%3Aschema.org%2FItemPage%22%3E%0A%20%20%20%20%3Ch2%20id%3D%22page_name%22%20itemprop%3D%22name%22%3E%0A%20%20%20%20%20%20Students%20jumping%20in%20front%20of%20Memorial%20Bell%20Tower%0A%20%20%20%20%3C%2Fh2%3E%0A%20%20%20%20%20%20%3Cdiv%20class%3D%22grid_5%22%3E%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%3Cimg%20itemprop%3D%22image%22%20id%3D%22main_image%22%20alt%3D%22Students%20jumping%20in%20front%20of%20Memorial%20Bell%20Tower%22%20src%3D%22%2Fimages%2Fbell_tower.png%22%3E%20%20%20%20%0A%20%20%20%20%20%20%3C%2Fdiv%3E%20%20%0A%20%20%20%20%20%20%3Cdiv%20id%3D%22metadata%22%20class%3D%22grid_7%22%20itemprop%3D%22about%22%20itemscope%20itemtype%3D%22http%3A%2F%2Fschema.org%2FPhotograph%22%3E%0A%20%20%20%20%20%20%20%20%3Cdiv%20id%3D%22item%22%20class%3D%22info%22%3E%0A%20%20%20%20%20%20%20%20%20%20%3Ch2%3EPhotograph%20Information%3C%2Fh2%3E%0A%20%20%20%20%20%20%20%20%20%20%3Cdl%3E%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdt%3ECreated%20Date%3C%2Fdt%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdd%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20circa%201981%0A%20%20%20%20%20%20%20%20%20%20%20%20%3C%2Fdd%3E%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdt%3ESubjects%3C%2Fdt%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdd%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ca%20href%3D%22%23buildings%22%3E%3Cspan%20itemprop%3D%22keywords%22%3EBuildings%3C%2Fspan%3E%3C%2Fa%3E%3Cbr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ca%20href%3D%22%23students%22%3E%3Cspan%20itemprop%3D%22keywords%22%3EStudents%3C%2Fspan%3E%3C%2Fa%3E%3Cbr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3C%2Fdd%3E%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdt%3EGenre%3C%2Fdt%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdd%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ca%20href%3D%22%23architectural_photos%22%3E%3Cspan%20itemprop%3D%22genre%22%3EArchitectural%20photographs%3C%2Fspan%3E%3C%2Fa%3E%3Cbr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Ca%20href%3D%22%23publicity_photos%22%3E%3Cspan%20itemprop%3D%22genre%22%3EPublicity%20photographs%3C%2Fspan%3E%3C%2Fa%3E%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%3C%2Fdd%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdt%3EDigital%20Collection%3C%2Fdt%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdd%3E%3Ca%20href%3D%22%23uapc%22%3EUniversity%20Archives%20Photographs%3C%2Fa%3E%3C%2Fdd%3E%20%0A%20%20%20%20%20%20%20%20%20%20%3C%2Fdl%3E%20%0A%20%20%20%20%20%20%20%20%3C%2Fdiv%3E%3C!--%20item%20--%3E%0A%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%3Cdiv%20id%3D%22building%22%20class%3D%22info%22%20itemprop%3D%22about%22%20itemscope%20itemtype%3D%22http%3A%2F%2Fschema.org%2FLandmarksOrHistoricalBuildings%22%3E%0A%20%20%20%20%20%20%20%20%20%20%3Ch2%3EBuilding%20Information%3C%2Fh2%3E%0A%20%20%20%20%20%20%20%20%20%20%3Cdl%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdt%3EBuilding%20Name%3C%2Fdt%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdd%3E%3Ca%20href%3D%22%23memorial_tower%22%3E%3Cspan%20itemprop%3D%22name%22%3EMemorial%20Tower%3C%2Fspan%3E%3C%2Fa%3E%3C%2Fdd%3E%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdt%3EDescription%3C%2Fdt%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdd%20itemprop%3D%22description%22%3EMemorial%20Tower%20honors%20those%20alumni%20who%20were%20killed%20in%20World%20War%20I.%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20The%20cornerstone%20was%20laid%20in%201922%20and%20the%20Tower%20was%20dedicated%20on%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20November%2011%2C%201949.%3C%2Fdd%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdt%3EAddress%3C%2Fdt%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdd%20itemprop%3D%22address%22%20itemscope%20itemtype%3D%22http%3A%2F%2Fschema.org%2FPostalAddress%22%3E%20%20%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Cspan%20itemprop%3D%22streetAddress%22%3E2701%20Sullivan%20Drive%3C%2Fspan%3E%3Cbr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3Cspan%20itemprop%3D%22addressLocality%22%3ERaleigh%3C%2Fspan%3E%2C%20%3Cspan%20itemprop%3D%22addressLocality%22%3ENC%3C%2Fspan%3E%20%3Cspan%20itemprop%3D%22postalCode%22%3E26707%3C%2Fspan%3E%20%20%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%3C%2Fdd%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdt%3ELatitude%2C%20Longitude%3C%2Fdt%3E%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Cdd%20itemprop%3D%22geo%22%20itemscope%3D%22%22%20itemtype%3D%22http%3A%2F%2Fschema.org%2FGeoCoordinates%22%3E%3Cspan%20itemprop%3D%22latitude%22%3E35.786098%3C%2Fspan%3E%2C%20%3Cspan%20itemprop%3D%22longitude%22%3E-78.663498%3C%2Fspan%3E%3C%2Fdd%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20%3C%2Fdl%3E%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%3C%2Fdiv%3E%3C!--%20building%20--%3E%0A%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%3Cdiv%20id%3D%22source%22%20class%3D%22info%22%3E%0A%20%20%20%20%20%20%20%20%20%20%3Ch2%3ESource%20Information%3C%2Fh2%3E%20%20%20%20%20%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%20%20...%20%20%20%20%20%0A%20%20%20%20%20%20%20%20%3C%2Fdiv%3E%3C!--%20source%20--%3E%0A%20%20%20%20%20%20%3C%2Fdiv%3E%20%20%0A%20%20%20%20%3C%2Fdiv%3E)
under the JSON tab.
YKK redo this link with the final version.

### itemref

One thing we have not marked up yet, is to associate the Photograph with the
image on the page. We need to fix that, because a rich snippet for a Photograph
is unlikely to show up for a photograph without a value for the `image` property. 
The problem is that the image is not nested within the same `div` where the 
Photograph is defined.

> Valid HTML is particularly important in pages that contain embedded markup. 
> All methods of embedding data within HTML use the structure of the HTML to 
> determine the meaning of the additional markup. [http://www.w3.org/wiki/Choosing_an_HTML_Data_Format#Good_Publishing_Practice](http://www.w3.org/wiki/Choosing_an_HTML_Data_Format#Good_Publishing_Practice)

While we have the content on our page relatively well organized to contain our
items, our layout and grid system mean that the image of the photograph is
not nested within the same `div` as the metadata about the photograph. When
coding new pages it is important to think not just about presentation but also
about how to structure the page with [both presentation and data in mind](http://semanticweb.com/schema-org-microdata-rdfa-and-black-friday-at-bestbuy_b24643). 
It makes marking up data easier if the 
properties of a thing are grouped together.

While in most
cases it will be easier to arrange our markup so that the properties of an
item are all within the same block on the page, there are times like this where
the style and layout of the page determines the structure. Microdata provides a 
rather simple mechanism for including properties that are outside of an item's 
scope.

Microdata uses the `itemref` attribute to make this more convenient.

> Note: The itemref attribute is not part of the microdata data model. It is merely a 
> syntactic construct to aid authors in adding annotations to pages where the 
> data to be annotated does not follow a convenient tree structure.
> [Microdata specification itemref attribute](http://www.whatwg.org/specs/web-apps/current-work/multipage/microdata.html#attr-itemref)

In our example above we already have an `id` of main_image_and an `itemprop` with 
the value "image" on the image. All that we need to give our Photograph an image
property  is add
`itemref="main_image"` to `div#metadata`. This adds it to the queue of locations
in the DOM to check for properties.

    <img id="main_image" alt="Students jumping in front of Memorial Bell Tower" 
            src="/images/bell_tower.png" itemprop="image"> 
    ... 
    <div id="metadata" class="grid_7" itemprop="about" itemscope itemtype="http://schema.org/Photograph" itemref="main_image">
      ...
    </div>
    
### Problems with Rich Snippets

No rich
snippet would show up in search results or the [Rich Snippets Testing Tool](http://www.google.com/webmasters/tools/richsnippets)
for this example right now.
Even though we valid Microdata and multiple Schema.org items marked up, 
at the time of this writing, Google would not use data from any of the 
possible items in a search result snippet.
Google currently only supports Rich Snippets for several of the Schema.org types 
(Applications, Authors, Events, Movie, Music, People, Products, Products with many offers, Recipes, Reviews, TV Series--
not all of which are Schema.org types). 
But using the 
[Structured Data Linter](http://linter.structured-data.org/) we get this 
possible preview for the LandmarksOrHistoricalBuildings item.

<p>
<img alt="Screenshot of page for digital photograph" src="/images/memorial_tower_snippet.png"/>
</p>

This is exactly the kind of attractive rich snippet we want users to see for our 
digitized resources. It uses the image and address to make a more clickable 
target. Hopefully the search engines will begin showing snippets
for some of the types cultural heritage organizations are most likely to be
making available.

### time and Datatypes

Another piece of data which would be good to add to the Photograph
is the created date (`dateCreated`) with an 
expected value of [`Date`](http://schema.org/Date).

The Microdata specification (unlike RDFa and Microformats-2) does not provide a 
generic mechanism for specifying data types.
Instead Microdata again [relies on a vocabulary](http://www.whatwg.org/specs/web-apps/current-work/multipage/microdata.html#names:-the-itemprop-attribute)
to define expected data types. 
Schema.org has four basic types: Boolean, Date, Number, and Text, but none of 
them are very well documented.

HTML5 has some new elements to allow inclusion of machine-readable data in HTML 
and these can be used for the Schema.org datatypes.
The [`time`](http://www.whatwg.org/specs/web-apps/current-work/multipage/text-level-semantics.html#the-time-element) 
and [`data`](http://www.whatwg.org/specs/web-apps/current-work/multipage/text-level-semantics.html#the-data-element)
elements have been added to HTML5. The specification of `time` has not been 
stable. In fact it was removed with some [strong objections](http://www.brucelawson.co.uk/2011/goodbye-html5-time-hello-data/)
and lots of exciting specification [drama](https://plus.google.com/107429617152575897589/posts/3ZEQAVkF6xd).

So while `time` is in the specification again, the Schema.org and Google
documentation adds its own confusion
to the matter, by using the `meta` element instead when it needs a date. 
Lots of examples around look like this:

    <meta itemprop="startDate" content="2016-04-21T20:00">
      Thu, 04/21/16
      8:00 p.m.

Using the `meta` and `link` elements within the `body` body of a document is 
[allowed in HTML5 when used with an `itemprop` attribute](http://www.whatwg.org/specs/web-apps/current-work/multipage/elements.html#flow-content). 
These
can sometimes be useful for Microdata in expressing the meaning of content or
a URL which has no
usefulness to a human reader. 
The `meta` element here is used to give the machine readable date near the date
visible to the user. It is hidden on the page, so goes against the general 
recommendation to not use hidden markup for Microdata. 
Further, the `meta` element does not even surround the free text version of the 
date disassociating them from each other. 

You could alternatively mark up the same text with `<time>` like so:
  
    <time itemprop="startDate" datetime="2016-04-21T20:00">
      Thu, 04/21/16
      8:00 p.m.
    </time>
    
The `time` element has the correct semantics for our Photograph:

    <time itemprop="dateCreated" datetime="1981">
      circa 1981
    </time>
    
I have made no attempt to handle the approximate date ("circa"). The current
specification processing rules does not handle many valid ISO8601 dates.
As dates and [ambiguity about dates](http://wiki.whatwg.org/wiki/Time_element#Fuzzy_dates) 
is important for describing cultural heritage 
materials, hopefully the HTML5 processing rules can be adjusted to handle all
valid ISO8601 dates. It seems as if the WHATWG has accepted a proposal to
support [year only dates](http://wiki.whatwg.org/wiki/Time_element#year_only),
which is a start.

(YKKK Move this to a footnote or remove? Also the MicrodataJS parser in use on this site erroneously takes 
the text value of the `time` element rather than the value of the `@datetime` 
attribute. As `time` is currently specified, the value for purposes of Microdata
of `time` is only falls back to the text content if there is no `@datetime` 
attribute.
Up until some time in December of 2011 the Google Rich Snippets Testing Tool, 
was throwing a warning that just a year was not a valid ISO8601 date,
[though it seems to be](http://en.wikipedia.org/wiki/ISO_8601#Years). The
HTML5 specification has [stricter processing rules](http://www.whatwg.org/specs/web-apps/current-work/multipage/common-microsyntaxes.html#vaguer-moments-in-time).) 

### itemid

The Building the Memorial Bell Tower is a unique resource which can be represented by this
Freebase URI:

[http://www.freebase.com/m/026twjv](http://www.freebase.com/m/026twjv)

In Microdata the [`itemid` attribute](http://www.whatwg.org/specs/web-apps/current-work/multipage/microdata.html#attr-itemid) 
can be used to associate an item with a
globally unique URL identifier, "so that it can be related to other items on pages
elsewhere on the web." 
This is the main 
mechanism by which Microdata natively supports something like linked data. 
("Item types are opaque identifiers, and user agents must not dereference 
unknown item types, or otherwise deconstruct them, in order to determine how to 
process items that use them." [Items](http://www.whatwg.org/specs/web-apps/current-work/multipage/microdata.html#items))
The meaning of the `@itemid` attribute is determined by the vocabulary. 

Unfortunately, Schema.org 
[does not document any use or support for the `itemid` attribute](http://www.w3.org/2011/webschema/track/issues/6)
at this time, though they ["strongly encourage the use of itemids"](http://groups.google.com/group/schemaorg-discussion/msg/f3317f1482d56232). 
The semantics of `itemid` in the Schema.org context seems 
[uncertain and overlapping with the consistent use of url properties](http://lists.w3.org/Archives/Public/public-vocabs/2011Nov/0023.html).

We'll add an `itemid` in any case.

    <div id="building" class="info" itemprop="about" itemscope="" itemtype="http://schema.org/LandmarksOrHistoricalBuildings" itemid="http://www.freebase.com/m/026twjv">
  

### Extending Schema.org

Another kind of property a cultural heritage organization might like to add to a 
landmark or building like the Memorial Tower are the 
events related to the building. In this case the cornerstone was laid in 1922 
and the tower dedicated on November 11, 1949. Other buildings could have events
in their history like the dates
they were designed or dates of renovations, derived from the drawings and 
project records. Museums
may be interested in various events in the history of a painting including
provenance and restorations. History museums and historical societies may also
want to refer to various historical events that relate to their exhibits. Each
of these may also want to promote various events happening in the future like
movie screenings, limited time exhibits, and tours. So it may be important to be
able to disambiguate whether an event is in the future or
of some historical significance.

Schema.org has an Event type defined as: "An event happening at a certain time at a 
certain location." That seems broad enough to apply it to either future or 
historic events. But
the message from Google's [support page on Rich Snippets for events](http://support.google.com/webmasters/bin/answer.py?hl=en&answer=164506)
gives more specific guidance:

> The goal of events snippets is to provide users with additional information 
> about specific events not to promote complementary products or services. Event 
> markup can be used to mark up events that occur on specific future dates, 
> such as a musical concert or an art festival.

Google has
a different view of the world than cultural heritage organizations.
Because of the focus on the future, we may not want to try to mark up historic
events, as rich snippets may be unlikely to show up for past events. 

Another option may be to use the Schema.org [Extension Mechanism](http://schema.org/docs/extension.html)
to possibly make it clearer to the search engines that certain types of events 
are different. 
As Schema.org is intended as a Web-scale schema, there is no possibility of 
having it fit every kind of data on the web.
The basic mechanism for extending an item type is to take any Schema.org type 
URL, add a forward slash to 
the end, and then add the camel cased name of the extension. So one possibility
to handle historic events would be to extend Event:

    http://schema.org/Event/HistoricEvent

At least the search engines will
understand that these items are some type of event. If enough other folks use the 
same extension and the search engines notice, then the search engines may start
using the data in a meaningful way. There is not a good, public, formal 
[process](http://www.w3.org/wiki/SchemaDotOrgProcess) 
for how to share extensions or advocate for their inclusion in Schema.org proper.
There is still work to be done to have a clear central location to share 
extensions or have a community process to work out new extensions.

For properties there are two options for mixing in a new property for 
an existing (or extended type). Schema.org prefers page authors to just add
the new property name as if it were defined by Schema.org. 
So our rights statement could be given this markup:

    <dd itemprop="rights">
          Reproduction and use of this material requires permission from 
          North Carolina State University.</dd>
  
The other option provided by the Microdata specification is to add a full URL
for the property like this:

    <dd itemprop="http://purl.org/dc/elements/1.1/rights">
          Reproduction and use of this material requires permission from 
          North Carolina State University.</dd>

### Another way forward for the cultural heritage sector?

These are just some of the ways in which Schema.org may not fit the needs of 
cultural heritage organizations very well. Other communities have already voiced
their concerns that their domains are not adequately specified. 

For instance,
the [rNews standard](http://dev.iptc.org/rNews) 
of the International Press and Telecommunications Council
was [added to schema.org](http://www.iptc.org/site/Home/Media_Releases/schema.org_adopts_IPTC's_rNews_for_news_markup). 
This was the first industry organization to 
work with the Schema.org partners to publish an expansion of
Schema.org to make it more robust and useful in a particular domain. The 
adoption of much of rNews has resulted in
news and publishing-related types being more expressive and better meeting the needs of 
news organizations.

Another change to the schema was the result of a [collaboration](http://www.whitehouse.gov/blog/2011/11/07/open-innovation-heroes-introducing-veterans-job-bank) 
between Schema.org
and the United States Office of Science and Technology Policy to 
[add support for job postings](http://blog.schema.org/2011/11/schemaorg-support-for-job-postings.html) 
to schema.org. One immediate use this was put to was to create a
[job search widget](https://www.nationalresourcedirectory.gov/home/job_search_widget) 
for use on government web sites to highlight job listings from 
employers who commit to hiring veterans. 
(See the [Veterans Job Bank](https://www.nationalresourcedirectory.gov/jobSearch/index).)

So this kind of partnership with domain experts seems like a clear way forward
for other groups.
Libraries, museums, archives, and other cultural heritage organizations could 
start to enumerate the places where the vocabulary could be modified to better
fit their data.
There has been some suggestion for [future discussions with the cultural sector](http://www.w3.org/wiki/WebSchemas#Proposals_from_and_for_Schema.org) 
to this end.

One suggested location for this kind of activity is the [W3C wiki](http://www.w3.org/wiki/SchemaDotOrgProcess),
which points to the simplicity of the submission for job postings.
YKK This is one place to hash out this kind of work as a community...

YKK... This p could probably be moved or removed.
Some of this work may already be available.
Work is ongoing to map other vocabularies to Schema.org. 
This provides a simpler way for organizations to expose their data through 
Microdata and Schema.org while still maintaining their data in their current
schema.
The Dublin Core Metadata Initiative
has begun an effort to do such a mapping. In each of these mappings there are 
certainly some areas where there is not overlap, so there is potential for 
expanding Schema.org in those directions. 

Conclusion
----------

Semantic markup of data embedded in HTML is a rapidly changing area. Whether or
not you implement Microdata and/or Schema.org, understanding ...
For cultural heritage organizations to YKK

Appendix: Resources
-------------------

### Examples from Cultural Heritage Organizations

* [NCSU Libraries' Digital Collections: Rare and Unique Materials](http://d.lib.ncsu.edu/collections)
  The example in this tutorial is based on this site.
* [Indianapolis Museum of Art](http://www.imamuseum.org/art/collections/artwork/untitled-calder-alexander)
  Uses CreativeWork and extends the type by adding the following properties:
  accessionNumber, collection, copyright, creditLine, dimensions, materials.
* [Biodiversity Heritage Library](http://www.biodiversitylibrary.org/bibliography/51518)
  Adds an "OCLC" property for a Book.
* [Sudoc French academic union catalogue](http://www.sudoc.fr/132133520.html) 
  Seems to only show the microdata representation to crawlers? 
  [more information](http://lists.w3.org/Archives/Public/public-lld/2011Jul/0013.html)
* [Sindice Search](http://sindice.com/search?q=schema&nq=&fq=class%3Ahttp%3A%2F%2Fschema.org%2F*%20format%3AMICRODATA&interface=guru&facet.field=domain)
  This search can be adjusted to find a specific schema.org type (class here).
  Faceting by the Microdata does not always seem to find sites that predominantly
  use Microdata rather than RDFa.



### Tools

These are tools which I have regularly used.

* [Rich Snippets Testing Tool](http://www.google.com/webmasters/tools/richsnippets) 
  Note that while it may not currently show a *rich* snippet example for 
  every schema.org type, you can use the data at the bottom of the page to
  insure that your Microdata is being parsed as you intended. The format
  here breaks every item out and shows references between them in a flat
  way.
* [Structured Data Linter](http://linter.structured-data.org/) 
  The best feature of this tool is the way that it displays your nested
  microdata as nested tables, making it easy to spot problems. 
  If the Rich Snippets Testing Tool doesn't show a rich snippet for your 
  content, this is a good alternative to see what your snippets *might* 
  look like.
  The snippets here do not cover every type either, but they cover a few
  different types from what the Rich Snippets Testing Tool does, for 
  instance it will show images for more types.
  The code is open source, so you can run your own instance to be able
  to check your syntax while you are in development.
  This is written by folks who have been part of the conversations around
  web vocabularies and structured data in HTML.
* [Live Microdata](http://foolip.org/microdatajs/live/)
  A good open-source tool for testing snippets of HTML marked up with
  Microdata. The [MicrodataJS source code](https://gitorious.org/microdatajs/)
  allows you to implement the Microdata DOM API on your own site, similar
  to how this tutorial outputs the JSON from parsing the page.
* [HTML5 Living Validator](http://html5.validator.nu/)
* [schema.rdfs.org list of tools](http://schema.rdfs.org/tools.html)

### Mappings

There are many efforts to map Schema.org to other vocabularies.
If you
maintain your metadata in one of these vocabularies, you can use these to 
help expose your data in a way that the search engines understand.

* [Dublin Core Alignment Task Group](http://wiki.dublincore.org/index.php/Schema.org_Alignment)
* [Partial BIBO mapping](http://schema.rdfs.org/mappings/bibo)
* [Alignment between rNews and Schema.org](http://dev.iptc.org/rNews-10-Implementation-Guide-HTML-5-Microdata)
* [schema.rdfs.org  list of mappings](http://schema.rdfs.org/mappings.html)

### Other Tutorials

* [Google Rich Snippets Videos](http://googlewebmastercentral.blogspot.com/2011/12/rich-snippets-instructional-videos.html?m=1):
  This series of short tutorial videos uses Microdata and Schema.org. 
* [Getting started with schema.org](http://schema.org/docs/gs.html) 
* [HTML Data Guide](https://dvcs.w3.org/hg/htmldata/raw-file/default/html-data-guide/index.html#publishers):
  This guide helps producers and consumers determine which structured data 
  syntax to use. It covers Microformats, RDFa, and Microdata. Highly Recommended. 
* [Why rNews?](http://dev.iptc.org/rNews-Why-rNews) is a good tutorial on how
  organizations often have good structured data that when made accessible 
  through HTML loses its meaning. 
* [Dive Into HTML5: “Distributed,” “Extensibility,” And Other Fancy Words](http://diveintohtml5.info/extensibility.html)
* [Spoonfeeding Library Data to Search Engines](http://go-to-hellman.blogspot.com/2011/07/spoonfeeding-library-data-to-search.html)
* [Extending microdata vocabularies](http://www.w3.org/wiki/HTML_Data_Vocabularies#Extending_microdata_vocabularies)

### Discussions

* [Public Vocabs list](http://lists.w3.org/Archives/Public/public-vocabs/)
  Schema.org discussion has moved over to this list.
* [W3C HTML Data Task Force](http://www.w3.org/wiki/Html-data-tf)
* [W3C Web Schemas Task Force](http://www.w3.org/2001/sw/interest/webschema.html)





