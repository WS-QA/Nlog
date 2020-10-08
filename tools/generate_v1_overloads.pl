@levels = ('Log', 'Trace','Debug','Info','Warn','Error','Fatal');
@clitypes = ('bool','char','byte','string','int','long','float','double','decimal','object');
@nonclstypes = ('sbyte','uint','ulong');

$loggercs = "../src/NLog/Logger-V1Compat.cs";

open(IN, "<$loggercs");
open(OUT, ">$loggercs.tmp");
while (<IN>)
{
    print OUT;
    last if (m/the following code has been automatically generated by a PERL/);
}

for $level (@levels) {

    if ($level eq "Log") {
        $level2 = "level";
        $level3 = "specified";
        $isenabled = "this.IsEnabled(level)";
        $arg0 = "LogLevel level, ";
        $param0 = qq!\n        /// <param name="level">The log level.</param>!;
    } else {
        $level2 = "LogLevel.$level";
        $level3 = "<c>$level</c>";
        $isenabled = "this.Is${level}Enabled";
        $arg0 = "";
        $param0 = "";
    }


    print OUT <<EOT;
        #region $level() overloads 

        /// <summary>
        /// Writes the diagnostic message at the $level3 level.
        /// </summary>$param0
        /// <param name="value">A <see langword="object" /> to be written.</param>
        [EditorBrowsable(EditorBrowsableState.Never)]
        public void $level(${arg0}object value)
        {
            if ($isenabled)
            {
                this.WriteToTargets($level2, "{0}", new object[] { value });
            }
        }

        /// <summary>
        /// Writes the diagnostic message at the $level3 level.
        /// </summary>$param0
        /// <param name="formatProvider">An IFormatProvider that supplies culture-specific formatting information.</param>
        /// <param name="value">A <see langword="object" /> to be written.</param>
        [EditorBrowsable(EditorBrowsableState.Never)]
        public void $level(${arg0}IFormatProvider formatProvider, object value) 
        {
            if ($isenabled)
            {
                this.WriteToTargets($level2, formatProvider, "{0}", new[] { value });
            }
        }

        /// <summary>
        /// Writes the diagnostic message at the $level3 level using the specified parameters.
        /// </summary>$param0
        /// <param name="message">A <see langword="string" /> containing format items.</param>
        /// <param name="arg1">First argument to format.</param>
        /// <param name="arg2">Second argument to format.</param>
        [EditorBrowsable(EditorBrowsableState.Never)]
        public void $level(${arg0}string message, object arg1, object arg2)
        {
            if ($isenabled)
            {
                this.WriteToTargets($level2, message, new[] { arg1, arg2 });
            }
        }

        /// <summary>
        /// Writes the diagnostic message at the $level3 level using the specified parameters.
        /// </summary>$param0
        /// <param name="message">A <see langword="string" /> containing format items.</param>
        /// <param name="arg1">First argument to format.</param>
        /// <param name="arg2">Second argument to format.</param>
        /// <param name="arg3">Third argument to format.</param>
        [EditorBrowsable(EditorBrowsableState.Never)]
        public void $level(${arg0}string message, object arg1, object arg2, object arg3)
        {
            if ($isenabled)
            {
                this.WriteToTargets($level2, message, new[] { arg1, arg2, arg3 });
            }
        }
EOT
    for $t (@clitypes) {
        print OUT <<EOT;

        /// <summary>
        /// Writes the diagnostic message at the $level3 level using the specified value as a parameter and formatting it with the supplied format provider.
        /// </summary>$param0
        /// <param name="formatProvider">An IFormatProvider that supplies culture-specific formatting information.</param>
        /// <param name="message">A <see langword="string" /> containing one format item.</param>
        /// <param name="argument">The argument to format.</param>
        [EditorBrowsable(EditorBrowsableState.Never)]
        public void $level(${arg0}IFormatProvider formatProvider, string message, $t argument)
        {
            if ($isenabled)
            {
                this.WriteToTargets($level2, formatProvider, message, new object[] { argument }); 
            }
        }

        /// <summary>
        /// Writes the diagnostic message at the $level3 level using the specified value as a parameter.
        /// </summary>$param0
        /// <param name="message">A <see langword="string" /> containing one format item.</param>
        /// <param name="argument">The argument to format.</param>
        [EditorBrowsable(EditorBrowsableState.Never)]
        public void $level(${arg0}string message, $t argument) 
        { 
            if ($isenabled)
            {
                this.WriteToTargets($level2, message, new object[] { argument });
            }
        }
EOT
    }
    for $t (@nonclstypes) {
        print OUT <<EOT;

        /// <summary>
        /// Writes the diagnostic message at the $level3 level using the specified value as a parameter and formatting it with the supplied format provider.
        /// </summary>$param0
        /// <param name="formatProvider">An IFormatProvider that supplies culture-specific formatting information.</param>
        /// <param name="message">A <see langword="string" /> containing one format item.</param>
        /// <param name="argument">The argument to format.</param>
        [CLSCompliant(false)]
        [EditorBrowsable(EditorBrowsableState.Never)]
        public void $level(${arg0}IFormatProvider formatProvider, string message, $t argument)
        { 
            if ($isenabled)
            {
                this.WriteToTargets($level2, formatProvider, message, new object[] { argument }); 
            }
        }

        /// <summary>
        /// Writes the diagnostic message at the $level3 level using the specified value as a parameter.
        /// </summary>$param0
        /// <param name="message">A <see langword="string" /> containing one format item.</param>
        /// <param name="argument">The argument to format.</param>
        [CLSCompliant(false)]
        [EditorBrowsable(EditorBrowsableState.Never)]
        public void $level(${arg0}string message, $t argument)
        { 
            if ($isenabled)
            {
                this.WriteToTargets($level2, message, new object[] { argument });
            }
        }
EOT
    }

    print OUT <<EOT;

        #endregion

EOT


}

while (<IN>)
{
    if (m/end of generated code/)
    {
        print OUT;
        last;
    }
}

while (<IN>)
{
    print OUT;
}
close(OUT);
close(IN);
unlink($loggercs);
rename("$loggercs.tmp", "$loggercs");

