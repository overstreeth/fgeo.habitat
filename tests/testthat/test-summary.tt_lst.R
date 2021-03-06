context("summary.tt_test()")

library(fgeo.data)

describe("summary.tt_test()", {
  census <- luquillo_top3_sp

  # Pick alive trees, of 10 mm or more
  pick <- census[census$status == "A" & census$dbh >= 10, ]
  species <- c("CASARB", "PREMON", "SLOBER")
  
  habitat <- luquillo_habitat
  tt_lst <- tt_test(census, species, habitat)
  
  
  
  it("returns the expected data structure", {
    out <- summary(tt_lst)
    expect_is(out, "data.frame")
    habitat_n <- length(unique(habitat$habitats))
    nms <- c("Species", paste0("Habitat_", seq_len(habitat_n)))
    expect_named(out, nms)
    expect_equal(nrow(out), length(species))
    
    columns_are_of_type_character <- all(vapply(out, is.character, logical(1)))
    expect_true(columns_are_of_type_character)
  })
  
  it("returns the expected output", {
    out <- summary(tt_lst)
    expect_known_output(out, "ref-summary-tt_lst", print = TRUE)
  })
})

