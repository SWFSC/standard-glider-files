import logging
import pathlib
import sys

# Ensure dbdreader is installed. In GitHub Actions, this will be handled by pip.
try:
    from dbdreader.decompress import decompress_file
except ImportError:
    raise ImportError('Cannot import dbdreader')


# Configure logging for the script
logging.basicConfig(
    format="%(module)s:%(asctime)s:%(levelname)s:%(message)s [line %(lineno)d]",
    level=logging.INFO, # Use INFO for standard output, DEBUG for more verbosity
    datefmt="%Y-%m-%d %H:%M:%S",
)

if __name__ == "__main__":
    cache_dir_name = "Cache"
    cacdir = pathlib.Path(cache_dir_name)

    if not cacdir.is_dir():
        logging.warning(
            "Cache directory '%s' not found. No .ccc files to decompress.", 
            cache_dir_name
        )
        sys.exit(0)

    ccc_file_count1 = sum(1 for item in cacdir.glob("*.ccc") if item.is_file())
    cac_file_count1 = sum(1 for item in cacdir.glob("*.cac") if item.is_file())
    logging.info(f"Using cache directory: {cacdir.absolute()}")
    logging.info(f"Number of .ccc files before: {ccc_file_count1}")
    logging.info(f"Number of .cac files before: {cac_file_count1}")

    logging.info("Starting decompression of .ccc files without .cac matches...")
    decompressed_count = 0
    for ccc_file in cacdir.glob("*.ccc"):
        logging.debug(f"Processing .ccc file: {ccc_file}")
        cac_file_name = ccc_file.stem + '.cac'
        cac_file_path = ccc_file.with_name(cac_file_name)

        if not cac_file_path.is_file():
            logging.info(f"Decompressing: {ccc_file}")
            try:
                decompress_file(ccc_file)
                decompressed_count += 1
            except Exception as e:
                logging.error("Error decompressing %s: %s", ccc_file, e)
        else:
            logging.debug("Skipping (already has .cac counterpart): %s", ccc_file)

    ccc_file_count2 = sum(1 for item in cacdir.glob("*.ccc") if item.is_file())
    cac_file_count2 = sum(1 for item in cacdir.glob("*.cac") if item.is_file())
    logging.info(f"Successfully decompressed {decompressed_count} new files.")
    logging.info(f"Number of .ccc files after: {ccc_file_count2}")
    logging.info(f"Number of .cac files after: {cac_file_count2}")

    if decompressed_count > 0:
        logging.info(
            "New .cac files were generated. These will be "
            + "committed back to the repository by the GitHub Action."
        )
