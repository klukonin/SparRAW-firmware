// SPDX-License-Identifier: AGPL-3.0-or-later
// @category wil6210
import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.*;
import ghidra.program.model.listing.*;
import java.io.*;

public class UcDecomp extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] a = getScriptArgs();   // outfile addr...
        DecompInterface di = new DecompInterface();
        DecompileOptions o = new DecompileOptions();
        di.setOptions(o);
        di.openProgram(currentProgram);
        PrintWriter w = new PrintWriter(new FileWriter(a[0]));
        FunctionManager fm = currentProgram.getFunctionManager();
        for (int i = 1; i < a.length; i++) {
            Function f = fm.getFunctionContaining(toAddr(Long.parseLong(a[i], 16)));
            if (f == null) { w.println("// " + a[i] + ": нет функции"); continue; }
            DecompileResults r = di.decompileFunction(f, 120, monitor);
            w.println("// ===== " + f.getEntryPoint() + " " + f.getName() + " =====");
            w.println(r.decompileCompleted() ? r.getDecompiledFunction().getC() : "// !! " + r.getErrorMessage());
        }
        w.close();
    }
}
