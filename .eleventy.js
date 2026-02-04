module.exports = function (eleventyConfig) {
  eleventyConfig.addPassthroughCopy("favicon.ico");
  eleventyConfig.addPassthroughCopy("**/*.css");
  eleventyConfig.addPassthroughCopy("**/*.svg");
  eleventyConfig.addPassthroughCopy("**/*.js");
  eleventyConfig.addPassthroughCopy("**/*.cast");
  eleventyConfig.addPassthroughCopy("status-bg.jpg");
  eleventyConfig.addPassthroughCopy("deps/**/*");
  eleventyConfig.addFilter("dateToStr", (dateObj) => {
    const d = new Date(dateObj)
    return d.toDateString()
  })
  eleventyConfig.addFilter("processState", (state) => {
    switch (state) {
      case "idea": return "lightbulb"
      case "wip": return "construction"
      case "done": return "circle-check-big"
      case "irrelevant": return "shredder"
      default: return "lightbulb"
    }
  })
}

