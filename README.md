A Bash-based Tool for FASTQ Phred Encoding Classification

Author: 2Filippaki (Fragoula Filippaki) 
Date : 17/05/2026
Version: v1.0 
Repository: https://github.com/2Filippaki/FastQ-files-Phred-categorization-tool

## Abstract

FQcategTool.sh is a lightweight Bash-based bioinformatics utility designed to automatically classify FASTQ files according to their Phred quality score encoding. The tool distinguishes between Phred+33 and Phred+64 formats by parsing quality score lines, converting ASCII characters into numerical values, and evaluating their distribution. The output is organized into structured directories, enabling efficient preprocessing of sequencing data.

---

## 1. Introduction

FASTQ files are a standard format in next-generation sequencing (NGS) data and contain both nucleotide sequences and associated quality scores. Correct interpretation of Phred encoding is essential for downstream analysis, as incorrect assumptions may lead to biased results in alignment, variant calling, and other bioinformatics workflows.

FQcategTool.sh was developed to automate the classification of FASTQ files into their respective Phred encoding systems, reducing manual inspection and minimizing preprocessing errors.

---

## 2. Methods

The script processes each FASTQ file within a user-defined directory and evaluates the quality score lines (fourth line of each FASTQ record). Each character is converted into its ASCII representation, and value ranges are analyzed to determine the encoding scheme.

Classification rules:

* Phred+33: ASCII range 33–64
* Phred+64: ASCII range 64–104

Files that do not match valid quality score distributions are flagged and skipped.

---

## 3. Implementation

The tool is implemented entirely in Bash and is compatible with Unix/Linux environments. It requires no external dependencies.

Main operations:

* Directory validation and user input handling
* FASTQ file iteration
* ASCII conversion of quality strings
* Encoding classification
* Automatic directory creation
* File relocation based on classification

---

## 4. Installation

Make the script executable:

```bash
chmod +x FQcategTool.sh
```

---

## 5. Usage

Run the tool using:

```bash
./FQcategTool.sh
```

The user will be prompted to provide a directory containing FASTQ files:

```text
Name of Directory:
```

Accepted inputs:

* Absolute path (recommended)
* Relative path

---

## 6. Output Structure

Input directory:

```text
input_directory/
├── sample1.fastq
├── sample2.fastq
├── sample3.fastq
```

Output after execution:

```text
input_directory/
├── Phred33/
├── Phred64/
```

---

## 7. Example Output

### Valid directory

```text
Valid Directory!
Created Phred33 folder.
Created Phred64 folder.
```

### Invalid directory

```text
Not a valid Directory.
```

### Phred+33 classification

```text
For file: ./sample1.fastq
The file is in Phred+33 format.
```

### Phred+64 classification

```text
For file: ./sample2.fastq
The file is in Phred+64 format.
```

### Invalid FASTQ file

```text
For file: ./sample3.fastq
No valid quality scores found, skipping...
```

---

## 8. Applications

This tool is suitable for preprocessing steps in:

* NGS quality control pipelines
* FASTQ format validation workflows
* Bioinformatics data organization
* Educational demonstrations of Phred encoding

---

## 9. Limitations

* Supports only Phred+33 and Phred+64 classification
* Does not perform sequencing quality trimming or filtering
* Requires correctly formatted FASTQ input files

---

## 10. Conclusion

FQcategTool.sh provides a simple and efficient approach for FASTQ file categorization based on Phred encoding. Its lightweight implementation makes it suitable for quick preprocessing tasks and educational use in bioinformatics training environments.

---

## 11. Reproducibility

The tool is fully reproducible in any Unix/Linux environment with Bash installed. No additional dependencies are required, ensuring portability across systems.
