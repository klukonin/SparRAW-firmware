/* boot__init_subsystems @ 0x8ed000, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_w_s13_w2, bf_w_s15_w17, boot__init_named_object, memcpy_fw, oob_mode__read_bit
 */
	.section .text.boot__init_subsystems,"ax",@progbits
	.global boot__init_subsystems
boot__init_subsystems:
	.global L_8ed000
L_8ed000:
	push_s blink
L_8ed002:
	bl.d L_8c02bc
L_8ed006:
	mov_s r2,0x9
L_8ed008:
	sub_s sp,sp,0xc
L_8ed00a:
	mov_s r15,r0
L_8ed00c:
	mov_s r0,0x1
L_8ed00e:
	mov_s r16,r0
L_8ed010:
	st_s r0,[r15]
L_8ed012:
	mov_s r13,0x0
L_8ed014:
	stw_s r13,[r15,0x26]
L_8ed016:
	mov_s r1,0x80188c
L_8ed01c:
	bl.d L_8c0460
L_8ed020:
	mov_s r0,sp
L_8ed022:
	mov_s r1,sp
L_8ed024:
	add r3,r15,0x28
L_8ed028:
	mov_s r0,r15
L_8ed02a:
	bl.d L_8ea994
L_8ed02e:
	mov_s r2,r13
L_8ed030:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ed032:
	extw_s r0,r0
L_8ed034:
	stw r0,[r15, 0x68]
L_8ed038:
	st_s r13,[r15,0x6c]
L_8ed03a:
	st_s r13,[r15,0x70]
L_8ed03c:
	st r16,[r15, 0x74]
L_8ed040:
	st r16,[r15, 0x78]
L_8ed044:
	st r16,[r15, 0x7c]
L_8ed048:
	add3 r14,r15,0x10
L_8ed04c:
	st r16,[r14]
L_8ed050:
	st r16,[r14, 0x4]
L_8ed054:
	bl.d L_8d7238
L_8ed058:
	st_s r13,[r14,0x8]
L_8ed05a:
	st_s r0,[r14,0xc]
L_8ed05c:
	mov_s r0,0x4
L_8ed05e:
	stb_s r0,[r14,0x10]
L_8ed060:
	mov_s r0,0x43
L_8ed062:
	stb_s r0,[r14,0x11]
L_8ed064:
	st 0x5b8d80,[r14, 0x1c]
L_8ed06c:
	ld_s r0,[r14,0x18]
L_8ed06e:
	mov_s r1,r13
L_8ed070:
	bic r0,r0,0x2f
L_8ed074:
	and r0,r0,0xffffe03f
L_8ed07c:
	st_s r0,[r14,0x18]
L_8ed07e:
	add r0,r14,0x18
L_8ed082:
	bl.d L_8e8390
L_8ed086:
	st_s r13,[r14,0x14]
L_8ed088:
	bl L_8e83b4
L_8ed08c:
	stw_s r13,[r14,0x20]
L_8ed08e:
	mov_s r0,0x64
L_8ed090:
	stw_s r0,[r14,0x22]
L_8ed092:
	stw_s r13,[r14,0x24]
L_8ed094:
	stw_s r0,[r14,0x26]
L_8ed096:
	stw_s r13,[r14,0x28]
L_8ed098:
	stw_s r13,[r14,0x2a]
L_8ed09a:
	stw_s r0,[r14,0x2c]
L_8ed09c:
	stw_s r13,[r14,0x2e]
L_8ed09e:
	stw_s r13,[r14,0x30]
L_8ed0a0:
	stw_s r0,[r14,0x32]
L_8ed0a2:
	stw_s r13,[r14,0x34]
L_8ed0a4:
	stw_s r13,[r14,0x36]
L_8ed0a6:
	stw_s r13,[r14,0x38]
L_8ed0a8:
	stw_s r0,[r14,0x3a]
L_8ed0aa:
	stw_s r13,[r14,0x3c]
L_8ed0ac:
	stw_s r0,[r14,0x3e]
L_8ed0ae:
	stw.a r0,[r15,0xc0]
L_8ed0b2:
	stw_s r13,[r15,0x2]
L_8ed0b4:
	stw_s r13,[r15,0x4]
L_8ed0b6:
	stw_s r0,[r15,0x6]
L_8ed0b8:
	stw_s r13,[r15,0x8]
L_8ed0ba:
	b.d L_8c0324
L_8ed0be:
	add_s sp,sp,0xc
