import data_io
from datetime import datetime

def main():
    test = data_io.read_test()
    test.fillna(0, inplace=True)
    
    feature_names = list(test.columns)
    feature_names.remove("date_time")

    features = test[feature_names].values

    print("Loading the classifier..")
    tstart = datetime.now()
    classifier = data_io.load_model()
    print("Time used,")
    print datetime.now() - tstart

    print("Making predictions..")
    tstart = datetime.now()
    predictions = classifier.predict_proba(features)[:,1]
    predictions = list(-1.0*predictions)
    recommendations = zip(test["srch_id"], test["prop_id"], predictions)
    print("Time used,")
    print datetime.now() - tstart

    print("Writing predictions to file..")
    tstart = datetime.now()
    data_io.write_submission(recommendations)
    print("Time used,")
    print datetime.now() - tstart

if __name__=="__main__":
    main()
