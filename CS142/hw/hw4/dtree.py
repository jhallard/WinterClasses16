import numpy as np

samples = 10
nfeatures = 4
features = [x for x in range(nfeatures)]


X = np.random.binomial(100, .5, (samples, nfeatures+1)) % 2


if __name__ == '__main__' :

    print "Data : %s " % str(X)
    print "\n\n"
    while len(features) > 0 :
        lowest = 1000
        lind = 0
        if not isinstance(features, list) : features = [features]
        for ind, x in enumerate(features) :
            print "\nTesting feature %s" % x
            nl, nr = ([a for a in X if a[x] > 0], [a for a in X if a[x] == 0])
            impl = impr = 0
            for i, a in enumerate(nl) :
                impl += 1 if X[i][nfeatures] > 0 else 0
            for i, a in enumerate(nr) :
                impr += 1 if X[i][nfeatures] > 0 else 0

            if impl > float(len(nl))/2.0 :
                impl = float(impl)/len(nl)
            else :
                impl = 1 - float(impl)/len(nl)

            if impr > float(len(nr)/2.0) :
                impr = float(impr)/len(nr)
            else :
                impr = 1.0 - float(impr)/len(nr)
            avgimp = (impl + impr)/2.0
            lind, lowest = (ind, avgimp) if avgimp < lowest else (lind, lowest)

            print "Impurity Left : %s" % str(impl)
            print "Impurity Right : %s" % str(impr)
            print "Avg Impurity : %s" % avgimp
        print "\n Feature to split on : %s" % lind
        del features[lind]
        print "Successfully Split on Feature, Next Level ...\n\n"


