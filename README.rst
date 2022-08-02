sphinx_rtd_theme QA tests
=========================

This project is for generating the ``sphinx_rtd_theme`` test matrix. These docs
are manually built and hosted locally for review.

Our test matrix is currently rather large:

* Sphinx versions 1.x - 6.x
* Docutils versions 0.16, 0.17, 0.18
* HTML 4 and HTML 5 writer
* Mobile, tablet, and desktop viewport sizes
* And recent versions of Chromium, Firefox, and Safari

Currently, this describes over 300 possible combinations in our test matrix :cold_sweat:

Running
-------

For now, it's manual and using Tox:

.. code:: console

    % make install
    % make build

You can rebuild a specific test case with:

.. code:: console

    % tox -e sphinx5-docutils18-html5

If you want to test against a branch of ``sphinx_rtd_theme``, you can manually
update the Tox configuration to point to a Git branch in a repo.

Evaluting
---------

This is open to interpretation. Comparing over 300 test cases is obviously not
possible. Even more confusing is that some of the differences are known
incompatibilities -- for instance footnote styles do not have parity between
HTML 4 and HTML 5 writers, they are just functionally similar.

Use your own judgement in picking versions to compare. You should compare more
than 1 pair of versions -- for instance compare Sphinx 4 and 5 if you are
evaluating the differences between Docutils 0.17 and 0.18.

To evaluate changes, first start a web server:

.. code:: console

    % make serve

Then go to http://localhost:8081, open up two versions side by side in separate
browser windows, and go through the output of some of the demo pages to look for
anomalies.

Check different viewport sizes and a few current browsers.
