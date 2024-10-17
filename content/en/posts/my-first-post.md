+++
title = 'My First Post'
date = 2024-10-17T18:40:04+02:00
draft = true
author = 'Andrii Soldatenko'
description = 'Sample article showcasing basic Markdown syntax and formatting for HTML elements.'
isStarred = true
+++



{{< highlight go >}}
// GetTitleFunc returns a func that can be used to transform a string to
// title case.
//
// The supported styles are
//
// - "Go" (strings.Title)
// - "AP" (see https://www.apstylebook.com/)
// - "Chicago" (see https://www.chicagomanualofstyle.org/home.html)
//
// If an unknown or empty style is provided, AP style is what you get.
func GetTitleFunc(style string) func(s string) string {
    switch strings.ToLower(style) {
    case "go":
        return strings.Title
    case "chicago":
        return transform.NewTitleConverter(transform.ChicagoStyle)
    default:
        return transform.NewTitleConverter(transform.APStyle)
    }
}
{{< / highlight >}}


> Don't communicate by sharing memory, share memory by communicating.<br>
> — <cite>Rob Pike[^1]</cite>

[^1]: The above quote is excerpted from Rob Pike's [talk](https://www.youtube.com/watch?v=PAAkCSZUG1c) during Gopherfest, November 18, 2015.