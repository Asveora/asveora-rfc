# Asveora RFC Build Finishings

Make sure to make the following adjustments to any generated HTML output of the merged `.md` RFC file stack.

## Remove Residual Files

Delete `_merged.md` from the `/build` directory once the HTML file is finished being built by the `rfc-build.bat` script.

## Contents to Add at the Beginning Of `<body>`

```HTML
<p>
	<strong>Asveora RFC v0</strong><br><br>
	To efficiently browse this RFC, please use the Table of Contents below that lists hyperlinks to all sections and subsections.<br>
	If you are looking for a specific term, definition, or rule, please use CTRL+F (for readers on Linux/Windows) or Command+F (for readers on MacOS) for a scoped search.

</p>
<br>
```

where "v0" should be the versioning number such as "v1" or "v2" within the first line.

## Rename the HTML Page Title

Rename the HTML page title from:

```HTML
<title>_merged</title>
```

to:

```HTML
<title>Asveora RFC v0</title>
```

where "v0" should be the versioning number such as "v1" or "v2" within the title.

## Rename the Generated HTML File

Rename the generated HTML build file from:

```
RFC
```

to:

```
asveora-rfc-v0
```

where "v0" should be the versioning number such as "v1" or "v2" within the filename.