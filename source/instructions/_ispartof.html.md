### 25. isPartOf and itemprop block

One statement that would be nice to make about this Photograph is that it is
part of a collection of other similar photographs, since the metadata 
on the page already
includes a "Digital Collection" field.
There is no such property
for a Photograph, but an ItemPage has an `isPartOf` property.
The problem with how things are already on the page
is that if we simply give the "Digital Collection" value an itemprop it will
become the property of the Photograph instead of the ItemPage because of how
it is nested. 

One solution would be to move this information on the page to outside of the 
Photograph information, so it is only found within the scope of the ItemPage.
If you have control of your page, this is probably the best solution. It may
be that there is a requirement that the "Digital Collection" link appear
where it currently does on the page, so one workaround would be to repeat the same 
information but using `meta` and other non-visble elements. It breaks the suggestion
to only markup with Microdata visible elements, but this approach may be
preferable.

There is one possible solution to this problem if the structure cannot be adjusted
to handle this. This is done here, just as an example of the kind of hackish
workaround Microdata allows but which should probably be avoided. Here's the
markup for this part of the page:

    <dd itemscope>
      <span itemprop="isPartOf" itemscope="" itemtype="http://schema.org/CollectionPage" id="isPartOf_digital">
        <a href="#uapc" itemprop="url"><span itemprop="name">University Archives Photographs</span>	</a>
      </span>
    </dd>

This creates an item (using `itemscope`) without a type. This blocks the internal
`isPartOf` itemprop from being inherited by the Photograph.
Then `@itemref` can be used to refer to just this property.

Anyone know of other solutions to this problem?