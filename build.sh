#!/bin/sh

ONLY_HTML5="${ONLY_HTML5}"

cat > builds/index.html <<EOF
<html>
  <body>
    <h1>Theme QA test builds</h1>

    <ul>

EOF

for environment in `cd .tox; find * -maxdepth 0 -type d`; do

    echo "${environment}"

    if [ -e ".tox/${environment}/bin/sphinx-build" ]; then
        docutils_version=`.tox/${environment}/bin/python -m pip freeze | grep -oP "(?<=docutils[^\d]{2})[\d\w\.]*$"`
        sphinx_version=`.tox/${environment}/bin/python -m pip freeze | grep -oP "(?<=Sphinx[^\d]{2})[\d\w\.]*$"`
        theme_version=`.tox/${environment}/bin/python -m pip freeze | grep -oP "(?<=sphinx-rtd-theme[^\d]{2})[\d\w\.]*$"`

        if [ -n "${ONLY_HTML5}" ]; then
            .tox/${environment}/bin/sphinx-build \
                -a \
                -b html \
                -Dhtml4_writer=0 \
                -d builds/doctrees \
                docs/ \
                builds/${environment}-html5/

            echo "<li><a href='${environment}-html5/demo/demo.html'>Sphinx <code>${sphinx_version}</code>, theme version <code>${theme_version}</code>, docutils <code>${docutils_version}</code>, HTML 5</a></li>" >> builds/index.html

            .tox/${environment}/bin/sphinx-build \
                -a \
                -b html \
                -Dhtml4_writer=1 \
                -d builds/doctrees \
                docs/ \
                builds/${environment}-html4/

            echo "<li><a href='${environment}-html4/demo/demo.html'>Sphinx <code>${sphinx_version}</code>, theme version <code>${theme_version}</code>, docutils <code>${docutils_version}</code>, HTML 4</a></li>" >> builds/index.html
        else
            .tox/${environment}/bin/sphinx-build \
                -a \
                -b html \
                -Dhtml4_writer=0 \
                -d builds/doctrees \
                docs/ \
                builds/${environment}/

            echo "<li><a href='${environment}/demo/demo.html'>Sphinx <code>${sphinx_version}</code>, theme version <code>${theme_version}</code>, docutils <code>${docutils_version}</code></a></li>" >> builds/index.html
        fi
    fi
done

cat >> builds/index.html <<EOF
    </ul>
  </body>
</html>
EOF
