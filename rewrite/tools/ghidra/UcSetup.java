// SPDX-License-Identifier: AGPL-3.0-or-later
// @category wil6210
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.*;
import ghidra.program.model.mem.*;
import ghidra.program.model.symbol.SourceType;
import ghidra.program.model.listing.*;
import ghidra.app.cmd.disassemble.DisassembleCommand;
import java.io.*;
import java.nio.file.*;
import ghidra.program.model.lang.*;
import java.math.BigInteger;

public class UcSetup extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] a = getScriptArgs();   // names.txt data.bin
        Memory mem = currentProgram.getMemory();
        byte[] data = Files.readAllBytes(Paths.get(a[1]));
        MemoryBlock b = mem.createInitializedBlock("uc_data", toAddr(0x800000L),
            new ByteArrayInputStream(data), data.length, monitor, false);
        b.setRead(true); b.setWrite(true); b.setExecute(false);
        MemoryBlock rest = mem.createUninitializedBlock("uc_ram", toAddr(0x800000L + data.length), 0x8000 - data.length, false);
        rest.setRead(true); rest.setWrite(true);
        MemoryBlock mmio = mem.createUninitializedBlock("mmio", toAddr(0x880000L), 0x40000, false);
        mmio.setRead(true); mmio.setWrite(true); mmio.setVolatile(true);
        MemoryBlock mir = mem.createByteMappedBlock("iccm_lo", toAddr(0L), toAddr(0x920000L), 0x1ecc4, false);
        mir.setRead(true); mir.setExecute(true);
        Register gp = currentProgram.getRegister("gp");
        if (gp == null) gp = currentProgram.getRegister("r26");
        currentProgram.getProgramContext().setValue(gp, toAddr(0x920000L), toAddr(0x93ecc3L), BigInteger.valueOf(0x800528L));
        currentProgram.getProgramContext().setValue(gp, toAddr(0L), toAddr(0x1ecc3L), BigInteger.valueOf(0x800528L));
        FunctionManager fm = currentProgram.getFunctionManager();
        int n = 0;
        for (String l : Files.readAllLines(Paths.get(a[0]))) {
            String[] p = l.trim().split("\\s+");
            if (p.length < 2) continue;
            Address ad = toAddr(Long.parseLong(p[0], 16));
            new DisassembleCommand(ad, null, true).applyTo(currentProgram, monitor);
            Function f = fm.getFunctionAt(ad);
            if (f == null) f = createFunction(ad, p[1]);
            else f.setName(p[1], SourceType.USER_DEFINED);
            if (f != null) n++;
        }
        println("functions: " + n);
    }
}
