import csv
from operator import itemgetter
import os
import json
import pickle
import pandas as pd
from datetime import datetime

def get_paths():
    paths = json.loads(open("SETTINGS.json").read())
    for key in paths:
        paths[key] = os.path.expandvars(paths[key])
    return paths

def read_train():
    print("Reading training data...")
    tstart = datetime.now()
    train_path = get_paths()["train_path"]
    x = pd.read_csv(train_path)
    # print the time interval
    print("Time used,")
    print datetime.now() - tstart
    return x

def read_test():
    print("Reading test data...")
    tstart = datetime.now()
    test_path = get_paths()["test_path"]
    x = pd.read_csv(test_path)
    print("Time used,")
    print datetime.now() - tstart
    return x

def save_model(model, isBook=True):
    if isBook:
        out_path = get_paths()["model_path_book"]
    else:
        out_path = get_paths()["model_path_click"]
    pickle.dump(model, open(out_path, "w"))

def load_model(isBook=True):
    if isBook:
        in_path = get_paths()["model_path_book"]
    else:
        in_path = get_paths()["model_path_click"]
    return pickle.load(open(in_path))

def write_submission(recommendations, submission_file=None):
    if submission_file is None:
        submission_path = get_paths()["submission_path"]
    else:
        path, file_name = os.path.split(get_paths()["submission_path"])
        submission_path = os.path.join(path, submission_file)
    rows = [(srch_id, prop_id)
        for srch_id, prop_id, rank_float
        in sorted(recommendations, key=itemgetter(0,2))]
    writer = csv.writer(open(submission_path, "w"), lineterminator="\n")
    writer.writerow(("SearchId", "PropertyId"))
    writer.writerows(rows)
