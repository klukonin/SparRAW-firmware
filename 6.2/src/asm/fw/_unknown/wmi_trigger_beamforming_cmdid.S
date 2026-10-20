/* wmi_trigger_beamforming_cmdid @ 0x8fc11c, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI_BRP_RX. STA_ID: %0d
 *   WMI_SLS STAMAC_ADDR: ADDR-%04X%08X
 *   wmi_trigger_beamforming_cmdid abborted: txss is allowed only if connected.
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, lmac_if_trigger_bf, mid_list__by_mid_fw, mid_list__find_by
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_trigger_beamforming_cmdid
wmi_trigger_beamforming_cmdid:
	.global L_8fc11c
L_8fc11c:
	push_s blink
L_8fc11e:
	bl L_8c01dc
L_8fc122:
	mov_s r13,r0
L_8fc124:
	bl.d L_8cc3dc
L_8fc128:
	mov_s r0,r1
L_8fc12a:
	mov_s r16,r0
L_8fc12c:
	ld_s r0,[r13]
L_8fc12e:
	breq_s r0,0,L_8fc160
L_8fc130:
	breq r0,0x1,L_8fc14c
L_8fc134:
	cmp_s r0,0x2
L_8fc136:
	mov.eq r0,blink
L_8fc13a:
	mov.eq r1,0x8f
L_8fc142:
	bl.eq.d L_8c9b28
L_8fc146:
	asl.eq r1,r1,0x5
L_8fc14a:
	b_s L_8fc192
	.global L_8fc14c
L_8fc14c:
	mov_s r1,0x100de6c
L_8fc152:
	mov_s r0,0x2b
L_8fc154:
	bl.d L_8dcc10
L_8fc158:
	ld_s r2,[r13,0x4]
L_8fc15a:
	ldb_s r0,[r13,0x4]
L_8fc15c:
	mov_s r1,0x1
L_8fc15e:
	b_s L_8fc18e
	.global L_8fc160
L_8fc160:
	ldw_s r2,[r13,0x10]
L_8fc162:
	mov_s r1,0x100de84
L_8fc168:
	mov_s r0,0x2b
L_8fc16a:
	bl.d L_8dcc80
L_8fc16e:
	ld_s r3,[r13,0xc]
L_8fc170:
	add r1,r13,0xc
L_8fc174:
	bl.d L_8cc024
L_8fc178:
	mov_s r0,r16
L_8fc17a:
	brne_s r0,0,L_8fc18a
L_8fc17c:
	mov_s r1,0x100dea8
L_8fc182:
	bl.d L_8dcba8
L_8fc186:
	mov_s r0,0x1b
L_8fc188:
	b_s L_8fc192
	.global L_8fc18a
L_8fc18a:
	ldb_s r0,[r0,0x8]
L_8fc18c:
	mov_s r1,0x0
	.global L_8fc18e
L_8fc18e:
	bl L_8dc228
	.global L_8fc192
L_8fc192:
	b L_8c0244
L_8fc196:
	nop_s
