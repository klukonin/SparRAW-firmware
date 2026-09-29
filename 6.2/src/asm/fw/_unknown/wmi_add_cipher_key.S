/* wmi_add_cipher_key @ 0x8fbf7c, 416 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI_ADD_CIPHER_KEY_CMD: CID[%d]ADDR-%04X%08X
 *   Add TX GTK
 *   Add RX GTK. CID: %d
 *   GLOBAL WMI_ADD_CIPHER_KEY_CMD MID[%d]ADDR-%04X%08X
 *   rejected RX GTK WMI COMMAND, No connection
 *   WMI_ADD_CIPHER_KEY_CMD rejected no CID for ADDR-%04X%08X
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, mid_list__by_mid_fw, mid_list__find_by, set_gtk, set_tk, u_schd__schedule
 * Глобалы (через gp): 0x8003fc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_add_cipher_key
wmi_add_cipher_key:
	.global L_8fbf7c
L_8fbf7c:
	push_s blink
L_8fbf7e:
	bl L_8c01d8
L_8fbf82:
	mov_s r13,r0
L_8fbf84:
	mov_s r17,r1
L_8fbf86:
	bl.d L_8cc3dc
L_8fbf8a:
	mov_s r0,r1
L_8fbf8c:
	mov.f r14,r0
L_8fbf90:
	beq_s L_8fc018
	.global L_8fbf92
L_8fbf92:
	ldb_s r0,[r13,0x2]
L_8fbf94:
	brne r0,0x0,L_8fc026
L_8fbf98:
	add r16,r13,0x2d
L_8fbf9c:
	mov_s r0,r14
L_8fbf9e:
	bl.d L_8cc024
L_8fbfa2:
	mov_s r1,r16
L_8fbfa4:
	mov.f r15,r0
L_8fbfa8:
	beq_s L_8fc0e2
L_8fbfaa:
	mov_s r0,r14
L_8fbfac:
	bl.d L_8cc024
L_8fbfb0:
	mov_s r1,r16
L_8fbfb2:
	add r1,r13,0xc
L_8fbfb6:
	mov_s r0,r15
L_8fbfb8:
	bl.d L_8e7140
L_8fbfbc:
	ldb_s r2,[r13]
L_8fbfbe:
	ldb r0,[r13, 0x32]
L_8fbfc2:
	ldb r3,[r13, 0x31]
L_8fbfc6:
	asl_s r0,r0,0x8
L_8fbfc8:
	or_s r3,r3,r0
L_8fbfca:
	ldb r0,[r13, 0x2e]
L_8fbfce:
	ldb r4,[r13, 0x2d]
L_8fbfd2:
	asl_s r0,r0,0x8
L_8fbfd4:
	or r4,r4,r0
L_8fbfd8:
	ldb r0,[r13, 0x2f]
L_8fbfdc:
	mov_s r1,0x100b578
L_8fbfe2:
	asl_s r0,r0,0x10
L_8fbfe4:
	or r4,r4,r0
L_8fbfe8:
	ldb r0,[r13, 0x30]
L_8fbfec:
	asl_s r0,r0,0x18
L_8fbfee:
	or r4,r4,r0
L_8fbff2:
	mov_s r0,0x20
L_8fbff4:
	bl.d L_8dcd00
L_8fbff8:
	ldb_s r2,[r15,0x8]
L_8fbffa:
	mov_s r0,0x35bf4
L_8fc000:
	ld.as r4,[gp,0x9e]
L_8fc004:
	mov_s r1,r17
L_8fc006:
	ldb_s r2,[r15,0x8]
L_8fc008:
	mov_s r3,0x2
L_8fc00a:
	mov r5,0x0
L_8fc00e:
	bl.d L_8e0c0c
L_8fc012:
	mov r6,0x0
L_8fc016:
	b_s L_8fc116
	.global L_8fc018
L_8fc018:
	mov_s r0,blink
L_8fc01a:
	mov_s r1,0x16ba
L_8fc020:
	bl L_8c9b28
L_8fc024:
	b_s L_8fbf92
	.global L_8fc026
L_8fc026:
	mov_s r15,0xff
L_8fc028:
	brne r0,0x2,L_8fc054
L_8fc02c:
	mov_s r1,0x100b5a8
L_8fc032:
	bl.d L_8dcba8
L_8fc036:
	mov_s r0,0x20
L_8fc038:
	mov_s r0,0x35bbc
L_8fc03e:
	ld.as r4,[gp,0x9e]
L_8fc042:
	mov_s r1,r17
L_8fc044:
	mov_s r2,0x0
L_8fc046:
	mov_s r3,0x2
L_8fc048:
	mov_s r5,r2
L_8fc04a:
	bl.d L_8e0c0c
L_8fc04e:
	mov_s r6,r2
L_8fc050:
	mov_s r16,r15
L_8fc052:
	b_s L_8fc084
	.global L_8fc054
L_8fc054:
	ld_s r0,[r14,0x14]
L_8fc056:
	cmp_s r0,0x1
L_8fc058:
	cmp.ne r0,0x20
L_8fc05c:
	bne_s L_8fc066
L_8fc05e:
	bl.d L_8cbb2c
L_8fc062:
	mov_s r0,r14
L_8fc064:
	b_s L_8fc070
	.global L_8fc066
L_8fc066:
	add r1,r13,0x2d
L_8fc06a:
	bl.d L_8cc024
L_8fc06e:
	mov_s r0,r14
	.global L_8fc070
L_8fc070:
	breq_s r0,0,L_8fc0d4
L_8fc072:
	ldb r16,[r0, 0x8]
L_8fc076:
	mov_s r1,0x100b5b4
L_8fc07c:
	mov_s r0,0x20
L_8fc07e:
	bl.d L_8dcc10
L_8fc082:
	mov_s r2,r16
	.global L_8fc084
L_8fc084:
	ldb r0,[r13, 0x32]
L_8fc088:
	ldb r3,[r13, 0x31]
L_8fc08c:
	asl_s r0,r0,0x8
L_8fc08e:
	or_s r3,r3,r0
L_8fc090:
	ldb r0,[r13, 0x2e]
L_8fc094:
	ldb r4,[r13, 0x2d]
L_8fc098:
	asl_s r0,r0,0x8
L_8fc09a:
	or r4,r4,r0
L_8fc09e:
	ldb r0,[r13, 0x2f]
L_8fc0a2:
	mov_s r1,0x100b5c8
L_8fc0a8:
	asl_s r0,r0,0x10
L_8fc0aa:
	or r4,r4,r0
L_8fc0ae:
	ldb r0,[r13, 0x30]
L_8fc0b2:
	asl_s r0,r0,0x18
L_8fc0b4:
	or r4,r4,r0
L_8fc0b8:
	mov_s r0,0x20
L_8fc0ba:
	bl.d L_8dcd00
L_8fc0be:
	mov_s r2,r17
L_8fc0c0:
	ldb_s r2,[r13]
L_8fc0c2:
	add r1,r13,0xc
L_8fc0c6:
	ldb_s r3,[r13,0x2]
L_8fc0c8:
	mov_s r0,r14
L_8fc0ca:
	bl.d L_8e6704
L_8fc0ce:
	mov r4,r16
L_8fc0d2:
	b_s L_8fc116
	.global L_8fc0d4
L_8fc0d4:
	mov_s r1,0x100b5fc
L_8fc0da:
	bl.d L_8dcba8
L_8fc0de:
	mov_s r0,0x20
L_8fc0e0:
	b_s L_8fc116
	.global L_8fc0e2
L_8fc0e2:
	ldb r0,[r13, 0x32]
L_8fc0e6:
	ldb r2,[r13, 0x31]
L_8fc0ea:
	asl_s r0,r0,0x8
L_8fc0ec:
	or_s r2,r2,r0
L_8fc0ee:
	ldb r0,[r13, 0x2e]
L_8fc0f2:
	ldb r3,[r13, 0x2d]
L_8fc0f6:
	asl_s r0,r0,0x8
L_8fc0f8:
	or_s r3,r3,r0
L_8fc0fa:
	ldb r0,[r13, 0x2f]
L_8fc0fe:
	mov_s r1,0x100b628
L_8fc104:
	asl_s r0,r0,0x10
L_8fc106:
	or_s r3,r3,r0
L_8fc108:
	ldb r0,[r13, 0x30]
L_8fc10c:
	asl_s r0,r0,0x18
L_8fc10e:
	or_s r3,r3,r0
L_8fc110:
	bl.d L_8dcc80
L_8fc114:
	mov_s r0,0x10
	.global L_8fc116
L_8fc116:
	b L_8c023c
L_8fc11a:
	nop_s
