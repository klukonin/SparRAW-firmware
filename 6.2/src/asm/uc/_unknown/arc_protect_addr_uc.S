/* arc_protect_addr_uc @ 0x920fb4, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   arc_protect_addr: id:%u %x:%x
 * Зовут его: ucode_cmd_0x41_handler
 * Зовёт сам: arc__program_action_point, uc_log__emit3
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global arc_protect_addr_uc
arc_protect_addr_uc:
	.global L_920fb4
L_920fb4:
	st.a r13,[sp,-0x14]
L_920fb8:
	st blink,[sp, 0x4]
L_920fbc:
	st_s r14,[sp,0x8]
L_920fbe:
	st_s r15,[sp,0xc]
L_920fc0:
	st r16,[sp, 0x10]
L_920fc4:
	sub_s sp,sp,0x20
L_920fc6:
	mov_s r16,r0
L_920fc8:
	mov_s r15,r1
L_920fca:
	mov_s r14,r2
L_920fcc:
	mov_s r1,0x10005f0
L_920fd2:
	mov_s r13,0x0
L_920fd4:
	mov_s r0,r13
L_920fd6:
	mov_s r2,r16
L_920fd8:
	mov r3,r15
L_920fdc:
	bl.d L_92d338
L_920fe0:
	mov r4,r14
L_920fe4:
	st r16,[sp]
L_920fe8:
	mov_s r2,0x1
L_920fea:
	st_s r2,[sp,0x1c]
L_920fec:
	st_s r13,[sp,0x14]
L_920fee:
	st_s r13,[sp,0x18]
L_920ff0:
	mov_s r3,0x2
L_920ff2:
	st_s r3,[sp,0xc]
L_920ff4:
	st_s r2,[sp,0x10]
L_920ff6:
	st_s r15,[sp,0x4]
L_920ff8:
	st r14,[sp, 0x8]
L_920ffc:
	bl.d L_920f10
L_921000:
	mov r0,sp
L_921004:
	add_s sp,sp,0x20
L_921006:
	ld blink,[sp, 0x4]
L_92100a:
	ld_s r14,[sp,0x8]
L_92100c:
	ld_s r15,[sp,0xc]
L_92100e:
	ld r16,[sp, 0x10]
L_921012:
	j_s.d [blink]
L_921014:
	ld.ab r13,[sp,0x14]
