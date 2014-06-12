import data_io
import train
from datetime import datetime

def main():
    test = data_io.read_test()
    ## deal with the NAs, and add features
    train.feature_eng(test)

    ## predict the booking_bool
    print("Loading the Booking classifier..")
    tstart = datetime.now()
    classifier = data_io.load_model(True)
    print("Time used,")
    print datetime.now() - tstart
    print("Making predictions on the booking_bool..")
    tstart = datetime.now()
    b_fnames = train.get_features(test, True)
    b_test_f =  test[b_fnames].values
    b_prob = classifier.predict_proba(b_test_f)[:,1]
    b_prob = list(-1.0*b_prob)
    print("Time used,")
    print datetime.now() - tstart

    ## predict the click_bool
    print("Loading the Click classifier..")
    tstart = datetime.now()
    classifier = data_io.load_model(False)
    print("Time used,")
    print datetime.now() - tstart
    print("Making predictions on the click_bool..")
    tstart = datetime.now()
    c_fnames = train.get_features(test, False)
    c_test_f =  test[c_fnames].values
    c_prob = classifier.predict_proba(c_test_f)[:,1]
    c_prob = list(-1.0*c_prob)
    print("Time used,")
    print datetime.now() - tstart

    ## Making Recommendations
    recommendations = zip(test["srch_id"], test["prop_id"], 4*b_prob+c_prob)
    
    print("Writing predictions to file..")
    tstart = datetime.now()
    data_io.write_submission(recommendations)
    print("Time used,")
    print datetime.now() - tstart

if __name__=="__main__":
    main()
