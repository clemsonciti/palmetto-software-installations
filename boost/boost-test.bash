#!/usr/bin/env bash

module add gcc

major=1
minor=65
patch=1

module add boost/${major}.${minor}.${patch}

cat << EOF > example.cpp
#include <boost/lambda/lambda.hpp>
#include <iostream>
#include <iterator>
#include <algorithm>

int main()
{
    using namespace boost::lambda;
    typedef std::istream_iterator<int> in;

    std::for_each(
        in(std::cin), in(), std::cout << (_1 * 3) << " " );
}
EOF

set -x

# Compile the example
# NOTE: boost modulefile sets the include path
c++ example.cpp -o example

# Test example
echo 1 2 3 | ./example

ls -lah
rm -f example.cpp example