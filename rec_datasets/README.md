# GRAM datasets

This directory contains preprocessed datasets used for training and evaluating the GRAM model.

## 📁 Dataset Structure

The `rec_datasets/` directory contains 4 datasets organized as follows:

```
rec_datasets/
├── Beauty/          # Amazon Beauty products dataset
├── Sports/          # Amazon Sports & Outdoors dataset  
├── Toys/            # Amazon Toys & Games dataset
└── Yelp/            # Yelp business reviews dataset
```

## 📄 File Descriptions

Each dataset folder contains the following 4 files:

### 1. `user_sequence.txt`
- **Format**: Space-separated User ASIN and Item ASINs per line
- **Description**: User interaction sequences ordered chronologically (first token is User ASIN, followed by Item ASINs)
- **Example**: `A1YJEY40YUW4SE B004756YJA B004ZT0SSG B0020YLEYK 7806397051 B002WLWX82`
  - `A1YJEY40YUW4SE`: User ASIN
  - `B004756YJA B004ZT0SSG B0020YLEYK 7806397051 B002WLWX82`: Item ASINs in chronological order
- **Usage**: Used for train, valid and test based on leave-one-out setting

### 2. `item_plain_text.txt`
- **Format**: One item per line with structured metadata
- **Description**: Concatenated rich item descriptions including title, brand, categories, description, price, sales rank, and etc (Yelp dataset has different fields).
- **Fields**:
  - `title`: Product name
  - `brand`: Manufacturer/brand name
  - `categories`: Product categories
  - `description`: Detailed product description
  - `price`: Product price
  - `salesrank`: Sales ranking in category
  ...
- **Example**: 
  ```
  B00DJQQEGQ title: shea butter 100 natural african ultra rich raw shea nuts...; brand: na; categories: beauty, skin care, body, moisturizers, body butter; description: would you like to have a glowing looking skin...; price: 17.97; salesrank: beauty: 20924
  ```

### 3. `similar_item_sasrec.txt`
- **Format**: Space-separated anchor item ID and top-20 similar item IDs per line
- **Description**: Pre-computed similar items using SASRec model (first token is anchor item, followed by top-20 most similar items)
- **Usage**: Used for collaborative semantics verbalization
- **Example**:
    ```
    B00DJQQEGQ B00HOHLKY2 B00L0C529Q B00KKKW03U B00JCE89SU B00KTAJAIY B00GGR7YGO B00IU079YM B00J4SCZFM B00JRGQ09S B00KLZO2JE B00KLJDYL2 B00KLA4INE B00KTP8Q1G B00KH6F6TM B00IIB82FS B00H8C82IU B00HDL5VA8 B00GBQSS56 B00L5KTZ0K B00K1H6AY2
    ```
    - `B00DJQQEGQ`: Anchor item ID
    - `B00HOHLKY2 B00L0C529Q ... B00K1H6AY2`: Top-1 to Top-20 most similar items to the anchor item


### 4. `item_generative_indexing_hierarchy_v1_*.txt`
- **Format**: Item ID and hierarchical textual tokens separated by `|`
- **Description**: Textual IDs for each item, organized in hierarchy
- **Filename Pattern**: `item_generative_indexing_hierarchy_v1_c{cluster}_l{level}_len{length}_split.txt`
  - `c{cluster}`: Number of clusters (e.g., c32, c128)
  - `l{level}`: Hierarchy levels (e.g., l5, l7, l9)
  - `len{length}`: Maximum sequence length of item texts when hierarchical clustering (e.g., len128, len32768)
- **Usage**: Used for hierarchical semantics indexing
- **Example**: 
  ```
    B000P24EI2 |▁loss|▁brake|▁fur|▁consolid|ren|▁scalp|▁profound
  ```
  - `B000P24EI2`: Item ID
  - `|▁loss|▁brake|▁fur|▁consolid|ren|▁scalp|▁profound`: Hierarchical textual tokens separated by `|`

## 📚 Data Sources

- **Amazon Review Data**: [Julian McAuley's Amazon Dataset](https://jmcauley.ucsd.edu/data/amazon/)
- **Yelp Open Dataset**: [Yelp Dataset Challenge](https://business.yelp.com/data/resources/open-dataset/)

## ⚠️ Notes

- All datasets are preprocessed and ready for training
- Preprocessing notebooks are available in [`preprocessing/`](../preprocessing/):
  - `0_nvembed_extraction.ipynb`: Extract item embeddings using NV-Embed-v2
  - `1_hierarchical_semantics_indexing.ipynb`: Hierarchical k-means + TF-IDF → hierarchical lexical IDs
  - `2_collaborative_semantics_verbalization.ipynb`: SASRec-based top-k similar item extraction
- Different datasets may have varying cluster and hierarchy parameters based on dataset characteristics

For more details about the GRAM model and training process, please refer to the [main README](../README.md).
