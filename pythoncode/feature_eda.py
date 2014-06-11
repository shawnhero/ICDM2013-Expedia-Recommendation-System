def nanrate(train, valname):
    train[valname+"_na"] = pd.isnull(train[valname])
    book_rate=[]
    click_rate=[]
    c_summary=[]
    b_summary=[]
    cond = []
    for i, gb in train.groupby(valname+"_na"):
        if i:
            cond.append(1)
        else:
            cond.append(0)
        book_rate.append(gb["booking_bool"].mean())
        click_rate.append(gb["click_bool"].mean())
        c_summary.append(gb["click_bool"].describe())
        b_summary.append(gb["booking_bool"].describe())
    df = pd.DataFrame(np.array([cond, click_rate, book_rate]), index=["Condition","Click Rate", "Book Rate"])
    df = df.transpose()
    print(df)
    df.plot( x="Condition",kind="bar")
    locs, labels = plt.xticks()
    plt.xticks(locs, ["Not NULL", "NULL"], size='small', rotation='horizontal')