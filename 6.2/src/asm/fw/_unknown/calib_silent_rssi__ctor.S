/* calib_silent_rssi__ctor @ 0x8f0004, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__install_handler_ptrs
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_silent_rssi__ctor
calib_silent_rssi__ctor:
	.global L_8f0004
L_8f0004:
	push_s blink
L_8f0006:
	bl.d L_8c01e0
L_8f000a:
	add2 r4,r0,0x15
L_8f000e:
	mov_s r2,0x0
L_8f0010:
	st_s r2,[r0,0x40]
L_8f0012:
	st_s r2,[r0,0x44]
L_8f0014:
	st_s r2,[r0,0x48]
L_8f0016:
	mov r3,-0xb
L_8f001a:
	add3 r1,r0,0x8
L_8f001e:
	stb_s r3,[r1,0xc]
L_8f0020:
	mov_s r13,0x3
L_8f0022:
	stb_s r13,[r1,0xd]
L_8f0024:
	stb_s r2,[r1,0xe]
L_8f0026:
	st_s r2,[r0,0x50]
L_8f0028:
	add3 r3,r0,0x18
L_8f002c:
	stb_s r2,[r3,0x10]
L_8f002e:
	add3 r14,r0,0x10
L_8f0032:
	st_s r2,[r14,0x54]
L_8f0034:
	mov_s r1,0x800634
L_8f003a:
	st_s r1,[r0,0x24]
L_8f003c:
	mov r5,0x800508
L_8f0044:
	ldb r1,[r5]
L_8f0048:
	mov lp_count,0x8
L_8f004c:
	sub_s r1,r1,0xb
L_8f004e:
	st_s r1,[r0,0x38]
L_8f0050:
	st_s r1,[r0,0x3c]
L_8f0052:
	mov_s r1,r2
L_8f0054:
	lp L_8f006c
L_8f0058:
	add r15,r0,0x20
L_8f005c:
	add_s r15,r15,r1
L_8f005e:
	stb_s r2,[r15,0x8]
L_8f0060:
	stb_s r2,[r15,0x10]
L_8f0062:
	add2 r12,r4,r1
L_8f0066:
	st_s r2,[r12]
L_8f0068:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8f006a:
	extb_s r1,r1
	.global L_8f006c
L_8f006c:
	mov_s r1,0x10
L_8f006e:
	add r0,r0,0xa0
L_8f0072:
	stb_s r1,[r0,0x14]
L_8f0074:
	stb_s r2,[r0,0x15]
L_8f0076:
	stb_s r13,[r0,0x16]
L_8f0078:
	stb_s r13,[r0,0x17]
L_8f007a:
	stb_s r2,[r0,0x18]
L_8f007c:
	mov_s r1,0xc
L_8f007e:
	stb_s r1,[r0,0x19]
L_8f0080:
	mov_s r1,0x18
L_8f0082:
	stb_s r1,[r0,0x1a]
L_8f0084:
	stb_s r1,[r0,0x1b]
L_8f0086:
	ldb r1,[r5]
L_8f008a:
	mov_s r2,0x32
L_8f008c:
	sub_s r1,r1,0xb
L_8f008e:
	extb_s r1,r1
L_8f0090:
	stb_s r1,[r0,0x1c]
L_8f0092:
	mov_s r1,0x1
L_8f0094:
	stb_s r1,[r0,0x1d]
L_8f0096:
	ldw_s r1,[r14,0x3e]
L_8f0098:
	stw_s r2,[r3,0x2]
L_8f009a:
	bset_s r1,r1,0x0
L_8f009c:
	bclr_s r1,r1,0x1
L_8f009e:
	stw_s r1,[r14,0x3e]
L_8f00a0:
	mov_s r1,0x9
L_8f00a2:
	stb_s r1,[r0,0x1f]
L_8f00a4:
	stw 0xc00,[r3]
L_8f00ac:
	ld_s r0,[r14,0x44]
L_8f00ae:
	stw_s r2,[r3,0x8]
L_8f00b0:
	bset_s r0,r0,0x0
L_8f00b2:
	bclr_s r0,r0,0x1
L_8f00b4:
	st_s r0,[r14,0x44]
L_8f00b6:
	stw 0xc00,[r3, 0x6]
L_8f00be:
	ldw_s r0,[r3,0xa]
L_8f00c0:
	stb_s r1,[r3,0x5]
L_8f00c2:
	bic r0,r0,0x3
L_8f00c6:
	bset_s r0,r0,0x1
L_8f00c8:
	stw_s r0,[r3,0xa]
L_8f00ca:
	mov_s r0,0x7
L_8f00cc:
	stb_s r0,[r3,0xb]
L_8f00ce:
	mov r0,0x400
L_8f00d2:
	stw_s r0,[r3,0xc]
L_8f00d4:
	mov_s r0,0x1e
L_8f00d6:
	b.d L_8c024c
L_8f00da:
	stw_s r0,[r3,0xe]
