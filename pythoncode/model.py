from sklearn.ensemble import RandomForestClassifier

def model():
	return RandomForestClassifier(n_estimators=50, 
                                            verbose=2,
                                            n_jobs=1,
                                            min_samples_split=10,
                                            random_state=1)
	