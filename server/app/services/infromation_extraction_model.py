import spacy

def extract_infromation(label,text):
    nlp = spacy.load('en_core_web_lg')
    doc = nlp(text)
    entities = [(ent.text, ent.label_) for ent in doc.ents]
    
    return entities
