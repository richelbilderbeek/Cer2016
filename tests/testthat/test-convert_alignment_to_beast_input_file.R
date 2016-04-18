context("convert_alignment_to_beast_input_file")

test_that("use case #1", {

  phylogeny_without_outgroup <- rcoal(n = 5)

  phylogeny_with_outgroup <- add_outgroup_to_phylogeny(
    phylogeny_without_outgroup,
    stem_length = 0
  )
  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny_with_outgroup,
    sequence_length = 10
  )
  image(alignment)
  beast_xml_input_file_using_cpp_exe  <- "temp_using_cpp_exe.xml"
  beast_xml_input_file_using_r_script <- "temp_using_r_script.xml"


  temp_fasta_filename <- "demonstrate_convert_alignment_to_beast_input_file.fasta"
  print(paste("Using temporary FASTA filename '",temp_fasta_filename,"'", sep=""))
  convert_alignment_to_beast_input_file_using_cpp_executable(
    alignment,
    mcmc_chainlength = 10000,
    rng_seed = 42,
    beast_xml_input_file_using_cpp_exe,
    temp_fasta_filename = temp_fasta_filename
  )
  expect_true(file.exists(beast_xml_input_file_using_cpp_exe))

  convert_alignment_to_beast_input_file_using_r_script(
    alignment,
    mcmc_chainlength = 10000,
    rng_seed = 42,
    beast_xml_input_file_using_r_script,
    temp_fasta_filename = temp_fasta_filename
  )
  expect_true(file.exists(beast_xml_input_file_using_r_script))

  if (!files_are_equal(beast_xml_input_file_using_cpp_exe,beast_xml_input_file_using_r_script)) {
    print(paste("ERROR: Files '",beast_xml_input_file_using_cpp_exe,"' and '",beast_xml_input_file_using_r_script,"' are different", sep=""))
  }

  expect_true(
    files_are_equal(
      beast_xml_input_file_using_cpp_exe,
      beast_xml_input_file_using_r_script
    )
  )

  # Can print either as they are identical
  print(readLines(beast_xml_input_file_using_r_script))

  # Clean up: remove the temporary files
  file.remove(beast_xml_input_file_using_cpp_exe)
  file.remove(beast_xml_input_file_using_r_script)
  expect_true(!file.exists(beast_xml_input_file_using_cpp_exe))
  expect_true(!file.exists(beast_xml_input_file_using_r_script))

})

test_that("use case #2", {


  phylogeny_without_outgroup <- rcoal(n = 5)

  phylogeny_with_outgroup <- add_outgroup_to_phylogeny(
    phylogeny_without_outgroup,
    stem_length = 0
  )
  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny_with_outgroup,
    sequence_length = 10
  )
  image(alignment)
  beast_xml_input_file <- "convert_alignment_to_beast_input_file_test_2.xml"
  temp_fasta_filename <- "convert_alignment_to_beast_input_file_test_2.fasta"
  print(paste("Using temporary FASTA filename '",temp_fasta_filename,"'", sep=""))
  convert_alignment_to_beast_input_file(
    alignment,
    mcmc_chainlength = 10000,
    rng_seed = 42,
    beast_filename = beast_xml_input_file,
    temp_fasta_filename = temp_fasta_filename
  )
  expect_true(file.exists(beast_xml_input_file))


})
